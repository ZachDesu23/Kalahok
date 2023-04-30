import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:kalahok/Components/tab/MenuLanguageDesignTab.dart';
import 'package:kalahok/Components/mob/MenuLanguageDesign.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/DataPrivacy.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var value;

  Future<Get> fetchSurvey() async {
    final response = await http
        .get(Uri.parse('https://kalahok-api-development.up.railway.app/surveys/code/$value'));
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(response.body);
      Get get = Get.fromJson(json.decode(response.body));
      Navigator.pop(context);
      prefs.setString('code', value);
      return Get.fromJson(json.decode(response.body));
    } else {
      throw Fluttertoast.showToast(
          msg: "ERROR CODE PLEASE TRY AGAIN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  @override
  void dispose(){
    super.dispose();
    password.dispose();
  }


  Future<void> _showMyDialog(context) async {
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
                Form(
                  key: _formKey,
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        'Enter your Passcode',
                        textAlign: TextAlign.center,
                        style: textTitle(size.height * .03, Color(0xFF334089)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        onChanged: (value){

                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Something';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF6783F6), width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF6783F6), width: 3.0),
                            )),
                      ),
                    ],
                  ),
                ),
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
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
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
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                         value = password.text;
                         fetchSurvey();

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
    Future.delayed(Duration.zero, () {
      _showMyDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide < 600;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: useMobLayout ? mobView3(context, 0.04, 0.02) : tabView(),
    );
  }

  Widget mobView3(context, double titleHeight, double normalText) {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesign(
        title: 'Choose Language',
        subTitle: 'Select the language to get started',
        faIcon: SvgPicture.asset('assets/image/bicolano.svg',height: size.height*0.12,),
        faIcon2: SvgPicture.asset('assets/image/Ilocano.svg',height: size.height*0.12,),
        faIcon3: SvgPicture.asset('assets/image/english1.svg',height: size.height*0.12,),
        faIcon4: Image.asset('assets/image/filipino.png',scale: 6,),
        text1: 'Bicolano',
        text2: 'Ilocano',
        text3: 'English',
        text4: 'Tagalog',
        widget:  DataPrivacy(),
        widget2: DataPrivacy(),
        widget3: DataPrivacy(),
        widget4: DataPrivacy());
  }

  Widget tabView() {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesignTab(
        title: 'Choose Language',
        subTitle: 'Select the language to get started',
        faIcon: SvgPicture.asset('assets/image/bicolano.svg',height: size.height*0.12,),
        faIcon2: SvgPicture.asset('assets/image/Ilocano.svg',height: size.height*0.12,),
        faIcon3: SvgPicture.asset('assets/image/english1.svg',height: size.height*0.12,),
        faIcon4: Image.asset('assets/image/filipino.png',scale: 6,),
        text1: 'Bicolano',
        text2: 'Ilocano',
        text3: 'English',
        text4: 'Tagalog',
        widget: DataPrivacy(),
        widget2: DataPrivacy(),
        widget3: DataPrivacy(),
        widget4: DataPrivacy());
  }
}
