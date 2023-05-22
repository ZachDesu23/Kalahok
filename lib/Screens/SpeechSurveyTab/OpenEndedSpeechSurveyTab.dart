import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kalahok/Components/mob/CategoricalSurvey.dart';
import 'package:kalahok/Components/mob/SurveyComponent.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/SpeechSurveyTab/LastPageSpeechTab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';


class OpenEndedSpeechSurveyTab extends StatefulWidget {
  final List demographicAudio;
  final List demographicType;
  final List categoricalAudio;
  final List categoricalType;
  final Widget widget;
  final Widget widget2;
  const OpenEndedSpeechSurveyTab({required this.widget, required this.widget2, required this.demographicType,required this.demographicAudio, required this.categoricalAudio, required this.categoricalType});

  @override
  State<OpenEndedSpeechSurveyTab> createState() => _OpenEndedSpeechSurveyTabState();
}

class _OpenEndedSpeechSurveyTabState extends State<OpenEndedSpeechSurveyTab> {
  final TextEditingController _controller =  TextEditingController();
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  final audioPlayer = AudioPlayer();
  int tappedIndex = -1;
  List<dynamic> audioF = [];
  List type = [];
  List<dynamic> text = [];
  List<int> and1=[];
  bool answerSelected = false;
  var audioFile;
  bool disable = false;
  bool date = false;
  int indexQ = 0;
  Get get = Get(
      id: 'id',
      code: 'code',
      language: 'language',
      title: 'title',
      description: '',
      demographicQuestions: [],
      categoricalQuestions: [],
      openEndedQuestions: []);
  double rating = 0;
  int ? group1Value;
  int TappedIndex = -1;
  late Future<Get> dataFuture;

  void getTypes() {
    get.openEndedQuestions.length;
    int count = get.openEndedQuestions.length;
    for (int i = 0; i < count; i++) {
      type.add(get.openEndedQuestions[i].type);
    }

    text.length=get.openEndedQuestions.length;
    audioF.length = get.openEndedQuestions.length;
    type.length = get.openEndedQuestions.length;
  }

  void nextQuestion() {
    setState(() {
      if (indexQ < get.openEndedQuestions.length - 1) {
        indexQ++;
        TappedIndex=-1;
      } else {
        setState(() {
          disable = true;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LastPageSpeechTab(
                demographicAudio: widget.demographicAudio,demographicType: widget.demographicType,categoricalAudio: widget.categoricalAudio,categoricalType: widget.categoricalType,openEndedAudio:  audioF,openEndedType: type,);
            },
          ));
        });
      }
    });
  }

  Future<Get> fetchSurvey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? code = prefs.getString('code');
    final response = await http.get(Uri.parse('$baseUrl/surveys/code/$code'));
    if (response.statusCode == 200) {
      getTypes();
      get = Get.fromJson(json.decode(response.body));
      return Get.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to fetch');
    }
  }

  Future play()async{
    if(!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio${get.demographicQuestions.length+get.categoricalQuestions.length+indexQ}');

  }

  Future stop()async{
    if(!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    audioF[indexQ]=path;

    print("Recorder is saved at $audioFile");

  }

  Future initRecorder()async{


    final status = await Permission.microphone.request();
    final statusStorage = await Permission.storage.request();
    if(status!= PermissionStatus.granted && statusStorage != PermissionStatus.granted){
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();

    isRecorderReady = true;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    recorder.closeRecorder();
  }

  @override
  void initState() {
    super.initState();
    dataFuture = fetchSurvey();
    initRecorder();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SurveyComponent(),
          SurveyComponentTwo(),
          SurveyComponentThree(text: "Open Ended Question"),
          Positioned(
              top: size.height * .07,
              left: size.width * .8,
              right: size.width * .07,
              child: IconButton(onPressed: (){
                setState(() {
                  dataFuture = fetchSurvey();
                });
              },icon:  Icon(Icons.refresh,size: size.width*0.12),color: Color(0xFF334089),)),
          Positioned(
              top: size.height * .07,
              left: size.width * .8,
              right: size.width * .07,
              child: IconButton(onPressed: (){
                setState(() {
                  dataFuture = fetchSurvey();
                });
              },icon:  Icon(Icons.refresh,size: size.width*0.12),color: Color(0xFF334089),)),
          Positioned(
            top: size.height * 0.15,
            left: size.width * 0.04,
            right: size.width * 0.04,
            bottom: size.height * 0.17,
            //Fetching survey
            child: FutureBuilder<Get>(
                future: fetchSurvey(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Text("loading"),
                    );
                  } else {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFF334089),width: 3)
                        ),
                        height:size.height*0.6,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //display Text
                              Text(
                                get.openEndedQuestions[indexQ].question,
                                textAlign: TextAlign.center,
                                style: textTitle(size.height*0.02, Colors.black),
                              ),
                              // MaterialButton(onPressed: () {
                              //
                              // },
                              //   height: 80,
                              //   shape: RoundedRectangleBorder(
                              //       side: BorderSide(color: Color(0xFF334089),width: 2),
                              //       borderRadius: BorderRadius.circular(25)),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(10.0),
                              //     child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     children: <Widget>[
                              //       Icon(Icons.volume_up_sharp,size: 80,color: Color(0xFF334089)),
                              //       Text("Question",style: textTitle(40, Color(0xFF334089)),)
                              //     ],
                              // ),
                              //   ),),
                              SizedBox(height: 20,),
                              MaterialButton(onPressed: () async {
                                if(recorder.isRecording){
                                  await stop();

                                  setState(() {

                                  });
                                }else{
                                  await play();
                                  setState(() {

                                  });
                                }

                              },
                                height: 80,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFF334089),width: 2),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      recorder.isRecording==false?Icon(Icons.mic,size: 80,color: Color(0xFF334089)):Icon(Icons.stop,size: 80,color: Color(0xFF334089)),
                                      Text("Answer",style: textTitle(size.width*.07, Color(0xFF334089)),)
                                    ],
                                  ),
                                ),),
                              SizedBox(height: 20,),
                              MaterialButton(onPressed: () async{
                                if(recorder.isStopped){
                                  AudioPlayer audioP = AudioPlayer();
                                  audioP.play(audioF[indexQ].toString(),isLocal: true);
                                  print(audioF[indexQ]);
                                }


                              },
                                height: 80,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFF334089),width: 2),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.play_arrow,size: 80,color: Color(0xFF334089)),
                                      Text("Review Answer",style: textTitle(size.width*.07, Color(0xFF334089)),)
                                    ],
                                  ),
                                ),),
                              // Text("-----DEMOGRAPHICS----"),
                              // Text(widget.demographicAudio.toString()),
                              // Text("-----CATEGORICAL----"),
                              // Text(widget.categoricalAudio.toString()),
                              // Text("-----OPEN - ENDED----"),
                              // Text(audioF.toString()),
                              // Text(text.isNotEmpty ? text.toString() : ""),
                              // Text(type.toString()),
                              // Text(and1.toString())
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),
          Positioned(
            top: size.height * .88,
            left: 10,
            right: 10,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (indexQ > 0) {
                        --indexQ;
                        if(get.openEndedQuestions[indexQ].type =="rating"){
                          rating = double.parse(text[indexQ].toString());
                        }else if(get.openEndedQuestions[indexQ].type =="choice"){
                          tappedIndex = and1.last;
                          and1.removeLast();
                        }else{
                          _controller.text = text[indexQ].toString();
                        }
                      } else {

                        Navigator.pop(context);
                      }
                    });

                  },
                  minWidth: size.width * .4,
                  height: size.height * .07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFE4C420),
                  child: Text(
                    'Back',
                    style: textNextText(size.height * .03, Color(0xFF334089)),
                  ),
                ),
                MaterialButton(
                  onPressed: () {

                    setState(() {
                      if(audioF[indexQ]==null){
                        Fluttertoast.showToast(
                            msg: "Please Answer the question",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        nextQuestion();
                      }
                    });

                  },
                  minWidth: size.width * .4,
                  height: size.height * .07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFE4C420),
                  child: Text(
                    'Next',
                    style: textNextText(size.height * .03, Color(0xFF334089)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

