import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/GetStarted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class LastPageSpeech extends StatefulWidget {
  final List demographicAudio;
  final List demographicType;
  final List categoricalAudio;
  final List categoricalType;
  final List openEndedAudio;
  final List openEndedType;
  const LastPageSpeech({required this.demographicType,required this.demographicAudio,required this.categoricalType,required this.categoricalAudio,required this.openEndedAudio,required this.openEndedType});

  @override
  State<LastPageSpeech> createState() => _LastPageSpeechState();
}

class _LastPageSpeechState extends State<LastPageSpeech> {

  Future postSurvey()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? code = prefs.getString('code');

    var data={};
    var demographicAnswer=[];
    var categoricalAnswer=[];
    var openEndedAnswer=[];
    var demoanswers={};
    var cateAnswer={};
    var openAnswer={};


    data["surveyCode"]=code.toString();

    for(int i=0;i<widget.demographicType.length;i++){
      demoanswers={};
      demoanswers["type"] = widget.demographicType[i];
      demoanswers["answer"] = widget.demographicAudio[i].toString();
      demographicAnswer.add(demoanswers);
    }
    data["demographicAnswers"]=demographicAnswer;


    for(int i=0;i<widget.categoricalType.length;i++){
      cateAnswer={};
      cateAnswer["type"] = widget.categoricalType[i];
      cateAnswer["answer"] = widget.categoricalAudio[i].toString();

      categoricalAnswer.add(cateAnswer);
    }
    data["categoricalAnswers"]=categoricalAnswer;


    for(int i=0;i<widget.openEndedType.length;i++){
      openAnswer={};
      openAnswer["type"] = widget.openEndedType[i];
      openAnswer["answer"] = widget.openEndedAudio[i].toString();
      openEndedAnswer.add(openAnswer);
    }
    data["openEndedAnswers"]=openEndedAnswer;

    var dio = Dio();
    var audioData = FormData();
    print(data);
    FormData formData = FormData.fromMap({
      "surveyCode":code,
      "demographicAnswers":demographicAnswer,"categoricalAnswers":categoricalAnswer,"openEndedAnswers":openEndedAnswer});

    for(int i=0;i<widget.demographicType.length;i++){
      formData.files.add(MapEntry("demographicAnswers:[$i][audio]",
          MultipartFile.fromFileSync(widget.demographicAudio[i])));
    }
    for(int i=0;i<widget.categoricalType.length;i++){
      formData.files.add(MapEntry("demographicAnswers:[$i][audio]",
          MultipartFile.fromFileSync(widget.categoricalAudio[i])));
    }
    for(int i = 0;i<widget.openEndedType.length;i++){
      formData.files.add(MapEntry("demographicAnswers:[$i][audio]",
          MultipartFile.fromFileSync(widget.openEndedAudio[i])));
    }

    // var response = await http.MultipartRequest("POST", Uri.parse("https://kalahok-api-development.up.railway.app/responses"));
    try {
      final response = await dio.post(
          "https://kalahok-api-development.up.railway.app/responses",
          data: formData, options: Options(headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      }));
      if (response.statusCode == 201) {

        final success = await prefs.remove('code');
        Fluttertoast.showToast(
            msg: "Survey Submitted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        ).then((value) =>
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (BuildContext context) {
              return GetStarted();
            },), (route) => false));
      } else {
        print("dito" + response.data['messages']);
        print(response.statusCode);
        print("no data");
      }
    }on DioError catch(ex){
      if(ex.response!.data['messages']!=''){
          print(ex.response?.data);
          print("Error Exception::${ex.response!.data['messages']}");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Thank you for participating this survey",
              style: TextStyle(fontFamily: 'Open Sans',fontWeight: FontWeight.w900,fontSize: 25,color: Color(0xFF334089)),textAlign: TextAlign.center,
            ),
            Image.asset('assets/image/Contact-us.png'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () {},
                // width 0.9 height 0.07 tablet
                // width
                minWidth: size.width * .9,
                height: size.height * .07,
                child: Text(
                  'Save Data Locally',
                  style: textTitle(size.height * .03, Color(0xFF334089)),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFE4C420),
              ),
            ),
            MaterialButton(
              onPressed: () {
                postSurvey();

              },
              // width 0.9 height 0.07 tablet
              // width
              minWidth: size.width * .9,
              height: size.height * .07,
              child: Text(
                'Save Data Online',
                style: textTitle(size.height * .03, Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.amber.shade700,
            ),
          ],
        ),
      ),
    );
  }
}
