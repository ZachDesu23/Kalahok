import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/GetStarted.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class LastPage extends StatefulWidget {
  final List demographicAnswer;
  final List demographicType;
  final List categoricalAnswer;
  final List categoricalType;
  final List openEndedAnswer;
  final List openEndedType;
  const LastPage({required this.demographicType,required this.demographicAnswer,required this.categoricalType,required this.categoricalAnswer,required this.openEndedAnswer,required this.openEndedType});

  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {

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

      demoanswers["type"]=widget.demographicType[i].toString();
      demoanswers["answer"]=widget.demographicAnswer[i];

      demographicAnswer.add(demoanswers);

    }
    data["demographicAnswers"] = demographicAnswer;


    for(int i=0;i<widget.categoricalType.length;i++){
      cateAnswer={};

      cateAnswer["type"]=widget.categoricalType[i].toString();
      cateAnswer["answer"]=widget.categoricalAnswer[i];

      categoricalAnswer.add(cateAnswer);
    }
    data["categoricalAnswers"] = categoricalAnswer;


    for(int i=0;i<widget.openEndedType.length;i++){
      openAnswer={};

      openAnswer["type"]=widget.openEndedType[i].toString();
      openAnswer["answer"]=widget.openEndedAnswer[i];

      openEndedAnswer.add(openAnswer);
    }

    data["openEndedAnswers"] = openEndedAnswer;
    print(data);

    var map = new Map<String,dynamic>();
    var dio = Dio();
    map["surveyCode"] = code;
    map["demographicAnswers"] = demographicAnswer;
    map["categoricalAnswers"] = categoricalAnswer;
    map["openEndedAnswers"] =  openEndedAnswer;

    FormData formData = new FormData.fromMap(map);
    var response = await dio.post("https://kalahok-api-development.up.railway.app/responses", data: formData);

    // final response = await http.post(Uri.parse("https://kalahok-api-development.up.railway.app/responses"),
    //     headers: { 'Content-type': 'application/json',
    //       'Accept': 'application/json'},
    //     body: jsonEncode(data));
    print(response.data);
    print(response.statusCode);
    if(response.statusCode==201){
      final success = await prefs.remove('code');
      Fluttertoast.showToast(
          msg: "Survey Submitted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      ).then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
        return GetStarted();
      },), (route)=>false));
    }else{

      print(response.statusCode);
      print("no data");
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
