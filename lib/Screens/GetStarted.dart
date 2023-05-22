import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/LanguagePage.dart';
import 'package:kalahok/Screens/Menu.dart';
import 'package:kalahok/Screens/TextAndAudioPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';


class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  Future getSavedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userPref = prefs.getString('user');

    Map<String,dynamic> userMap = jsonDecode(userPref!) as Map<String, dynamic>;

    if(userPref.isNotEmpty){
      _showMyDialog(userMap);
    }
    print(userMap);
  }

  Future<void> _showMyDialog(data) async {
    Size size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: size.width * .6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You have save your answer locally send the data to web?",textAlign: TextAlign.center,
              style: textTitle(size.height * .03, Color(0xFF334089)),)

              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    minWidth: size.width * .25,
                    height: 50,
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open Sans',
                        fontSize: 20,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xFFd9d9d9),
                  ),
                  MaterialButton(
                    onPressed: () async{
                      var dio = Dio();
                      print(data);
                      var response = await dio.post("$baseUrl/responses", data: data);

                      // final response = await http.post(Uri.parse("https://kalahok-api-development.up.railway.app/responses"),
                      //     headers: { 'Content-type': 'application/json',
                      //       'Accept': 'application/json'},
                      //     body: jsonEncode(data));
                      print(response.data);
                      print(response.statusCode);
                      if(response.statusCode==201){
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        final success = await prefs.remove('user');
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
                    },
                    minWidth: size.width * .25,
                    height: 50,
                    child: Text(
                      'Submit',
                      style: textNextText(20, Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xFFFB731C),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  @override
  Widget build(BuildContext context) {

    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobUseLayout = shortestSide <=600;
    debugPrint(shortestSide.toString());
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: mobUseLayout?  buildStackMob(context,size):buildStackTab(context, size),
    );
  }

  Widget buildStackMob(context,Size size) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset('assets/image/bosesKo.png',height: 300),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //     'Kalahok',
          //     style: textTitle(size.height * 0.06, Color(0xFF334089)),
          //   ),
          // ),
        ],
      ),
    Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width*.8,
            height: size.height*.06,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  Menu()
                ));

              },
              child:  Text('Get Started', style: textText(size.height*0.035, Colors.white)),
              color: Color(0xFFFB731C),
              textColor: Colors.white,
              elevation: 5,
            ),
          ),),
    )
    ]);
  }

  Widget buildStackTab(context,Size size){
    Orientation orientation = MediaQuery.of(context).orientation;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset('assets/image/bosesKo.png',height: 300,),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //     '',
          //     style: textTitle(size.height * 0.06, Color(0xFF334089)),
          //   ),
          // ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width*.8,
            height: size.height*.07,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    Menu()
                ));

              },
              child:  Text('Get Started', style: textText(size.height*0.035, Colors.white)),
              color: Color(0xFFFB731C),
              textColor: Colors.white,
              elevation: 5,
            ),
          ),),
      )
    ]);
  }
}
