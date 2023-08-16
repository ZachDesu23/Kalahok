import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kalahok/Screens/TextSurvey/CategoricalSurvey.dart';
import 'package:kalahok/Components/mob/SurveyComponent.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/SpeechSurvey/CategoricalSpeechSurvey.dart';
import 'package:kalahok/Screens/SpeechSurveyTab/CategoricalSpeechSurveyTab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DemographicsSpeechSurvey extends StatefulWidget {
  final Widget widget;
  final Widget widget2;
  const DemographicsSpeechSurvey({super.key, required this.widget, required this.widget2});

  @override
  State<DemographicsSpeechSurvey> createState() => _DemographicsSpeechSurveyState();
}

class _DemographicsSpeechSurveyState extends State<DemographicsSpeechSurvey> {
  final TextEditingController _controller =  TextEditingController();
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  final audioPlayer = AudioPlayer();
  List<dynamic> audioF = [];
  List type = [];
  List<dynamic> text = [];
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
  final DateTime _dateTime = DateTime.now();
  int TappedIndex = -1;
  late Future<Get> dataFuture;

  void getTypes() {
    get.demographicQuestions.length;
    int count = get.demographicQuestions.length;
    for (int i = 0; i < count; i++) {
      type.add(get.demographicQuestions[i].type);
    }

    text.length=get.demographicQuestions.length;
    audioF.length = get.demographicQuestions.length;
    type.length = get.demographicQuestions.length;

  }

  void nextQuestion() {
    setState(() {
      if (indexQ < get.demographicQuestions.length - 1) {
        indexQ++;
        TappedIndex=-1;
      } else {
        setState(() {
          disable = true;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CategoricalSpeechSurvey(
                widget: Text(''),
                widget2: Text(''),
                demographicAudio: audioF,
                demographicType: type,
              );
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
    await recorder.startRecorder(toFile: 'audio$indexQ');

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

    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));

    isRecorderReady = true;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recording'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                StreamBuilder<RecordingDisposition>(
                    builder: (context, snapshot) {
                      final duration = snapshot.hasData ?snapshot.data!.duration : Duration.zero;
                      String twoDigits(int n) => n.toString().padLeft(2, '0');
                      final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                      final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
                      return Center(
                        child: Text(
                            '$twoDigitMinutes:$twoDigitSeconds',style:textTitle(50, Color(0xFF334089))),
                      );

                    },

                    stream:recorder.onProgress),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Stop Recording'),
              onPressed: () async{
                await stop();
                print(recorder.isRecording);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    initRecorder();
    dataFuture = fetchSurvey();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(onPressed: (){
              setState(() {
                dataFuture = fetchSurvey();
              });
            },icon:  Icon(Icons.refresh,size: size.width*0.1),color: Colors.white,),
          ),

        ],

        title: Text('Demographic Question',style: TextStyle(fontSize: 25,color: Colors.white)),
        backgroundColor: Color(0xFF334089),

      ),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<Get>(
              future: fetchSurvey(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                    return Container(
                      child: Text("ERROR"),
                    );
                  } else if(snapshot.hasData){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Question ${indexQ+1}/${snapshot.data?.demographicQuestions.length}',style: textTitle(size.width*0.067, Color(0xFF334089)),),
                          ),
                          LinearProgressIndicator(
                            value: indexQ/get.demographicQuestions.length,

                            color: Color(0xFF334089),
                            semanticsLabel: 'Linear progress indicator',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xFF334089),width: 3)
                              ),
                              height:size.height*0.7,
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //display Text
                                    Text(
                                      get.demographicQuestions[indexQ].question,
                                      textAlign: TextAlign.center,
                                      style: textTitle(size.height*0.02, Colors.black),
                                    ),
                                    SizedBox(height: 20,),

                                    MaterialButton(onPressed: () async {
                                      if(recorder.isRecording){

                                        setState(() {
                                        });
                                      }else{
                                        await play();
                                        _showMyDialog();
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
                                            Icon(Icons.mic,size: 80,color: Color(0xFF334089)),
                                            Text("Answer",style: textTitle(25, Color(0xFF334089)),)
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
                                            Text("Review Answer",style: textTitle(25, Color(0xFF334089)),)
                                          ],
                                        ),
                                      ),),
                                    // Text(audioF.toString()),
                                    // Text(text.isNotEmpty ? text.toString() : ""),
                                    // Text(type.toString()),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          buildMaterialButton(context, size),
                                          SizedBox(width: 20,),
                                          buildMaterialNext(size),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }else{
                    return Text("Loading");
                  }
                }
              ),

    );
  }

  MaterialButton buildMaterialNext(Size size) {
    return MaterialButton(
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
          minWidth: size.width * .35,
          height: size.height * .05,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color(0xFFE4C420),
          child: Text(
            'Next',
            style: textNextText(size.height * .03, Color(0xFF334089)),
          ),
        );
  }

  MaterialButton buildMaterialButton(BuildContext context, Size size) {
    return MaterialButton(
                onPressed: () {
                  setState(() {
                    if (indexQ > 0) {
                      --indexQ;
                      if(get.demographicQuestions[indexQ].type =="rating"){
                        rating = double.parse(text[indexQ].toString());
                      }else if(get.demographicQuestions[indexQ].type =="choice"){

                      }else{
                        _controller.text = text[indexQ].toString();
                      }
                    }else{
                      Navigator.pop(context);
                    }
                  });
                },
                minWidth: size.width * .35,
                height: size.height * .05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFE4C420),
                child: Text(
                  'Back',
                  style: textNextText(size.height * .03, Color(0xFF334089)),
                ),
              );
  }
}

