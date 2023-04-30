import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kalahok/Components/mob/LastPage.dart';
import 'package:kalahok/Components/mob/SurveyComponent.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OpenEndedPage extends StatefulWidget {
  final List demographicAnswer;
  final List demographicType;
  final List categoricalAnswer;
  final List categoricalType;
  final Widget widget;
  final Widget widget2;
  const OpenEndedPage(
      {required this.widget, required this.widget2, required this.demographicType,required this.demographicAnswer,required this.categoricalType,required this.categoricalAnswer});

  @override
  State<OpenEndedPage> createState() => _OpenEndedPageState();
}

class _OpenEndedPageState extends State<OpenEndedPage> {
  final TextEditingController _controller =  TextEditingController();
  List<String> type = [];
  List<dynamic> text = [];
  String? d;
  bool answerSelected = false;
  bool disable = false;
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
  int totalTC = 0;

  void nextQuestion() {
    setState(() {
      if (indexQ < get.openEndedQuestions.length-1) {
        indexQ++;
      } else {
        setState(() {
          disable = true;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LastPage(demographicAnswer: widget.demographicAnswer,demographicType: widget.demographicType,categoricalAnswer: widget.categoricalAnswer,categoricalType: widget.categoricalType,openEndedAnswer:  text,openEndedType: type,);
            },
          ));
        });
      }
    });
  }

  // Future postSurvey()async{
  //
  //   var data={};
  //   var demographicAnswer=[];
  //   var categoricalAnswer=[];
  //   var openEndedAnswer=[];
  //   var demoanswers={};
  //   var cateAnswer={};
  //   var openAnswer={};
  //
  //
  //   data["surveyCode"]=code;
  //
  //   for(int i=0;i<widget.demographicType.length;i++){
  //     demoanswers={};
  //
  //     demoanswers["type"]=widget.demographicType[i].toString();
  //     demoanswers["answer"]=widget.demographicAnswer[i];
  //
  //     demographicAnswer.add(demoanswers);
  //
  //   }
  //   data["demographicAnswers"] = demographicAnswer;
  //
  //
  //   for(int i=0;i<widget.categoricalType.length;i++){
  //     cateAnswer={};
  //
  //     cateAnswer["type"]=widget.categoricalType[i].toString();
  //     cateAnswer["answer"]=widget.categoricalAnswer[i];
  //
  //     categoricalAnswer.add(cateAnswer);
  //   }
  //   data["categoricalAnswers"] = categoricalAnswer;
  //
  //
  //   for(int i=0;i<type.length;i++){
  //     openAnswer={};
  //
  //     openAnswer["type"]=type[i].toString();
  //     openAnswer["answer"]=text[i];
  //
  //     openEndedAnswer.add(openAnswer);
  //   }
  //
  //   data["openEndedAnswers"] = openEndedAnswer;
  //
  //   final response = await http.post(Uri.parse("https://api.dev.kalahokph.net/responses"),
  //       headers:{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(data));
  //   if(response.statusCode==201){
  //
  //   }
  //
  //
  // }

  Future<Get> fetchSurvey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? code = prefs.getString('code');

    final response = await http
        .get(Uri.parse('https://kalahok-api-development.up.railway.app/surveys/code/$code'));
    if (response.statusCode == 200) {
      get = Get.fromJson(json.decode(response.body));
      return Get.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to fetch');
    }
  }

  void getTypes() {

    int count2 = get.openEndedQuestions.length;
    for (int i = 0; i < count2; i++) {
      type.add(get.openEndedQuestions[i].type);
    }

    text.length = get.openEndedQuestions.length;

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchSurvey().then((value) => getTypes());

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          const SurveyComponent(),
          const SurveyComponentTwo(),
          const SurveyComponentThree(text: "Open Ended Question"),
          Positioned(
            top: size.height * 0.15,
            left: size.width * 0.04,
            right: size.width * 0.04,
            bottom: size.height * 0.17,
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
                            children: [
                              Text(
                                get.openEndedQuestions[indexQ].question,
                                style: textTitle(20, Colors.black),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Text',
                                          hintText: 'Enter Text',
                                        ),
                                        controller: _controller),
                                  ),
                                  MaterialButton(
                                    minWidth: size.width*0.5,
                                    color:  Color(0xFF334089),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    onPressed: () {
                                      setState(() {
                                        if (_controller.text.isNotEmpty) {
                                          text[indexQ]=_controller.text;
                                          _controller.clear();
                                          answerSelected = true;
                                          nextQuestion();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text("Text is empty"),
                                          ));
                                        }
                                      });
                                    },
                                    child: Text("Add Response",style: TextStyle(color: Colors.white),),
                                  )
                                ],
                              ),
                              Text("DemoType"),
                              Text(widget.demographicAnswer.isNotEmpty ? widget.demographicAnswer.toString() : ""),
                              Text(widget.demographicType.toString()),
                              Text("Catego"),
                              Text(widget.categoricalAnswer.isNotEmpty ? widget.categoricalAnswer.toString() :""),
                              Text(widget.categoricalType.toString()),
                              Text("Open ended"),
                              Text(text.isNotEmpty ? text.toString():""),
                              Text(type.toString()),
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
                        _controller.text = text[indexQ].toString();
                      } else {
                        Navigator.pop(context);
                      }
                    });
                    _controller.text;
                  },
                  minWidth: size.width * .4,
                  height: size.height * .07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFE4C420),
                  child: Text('Back',
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
