import 'package:flutter/material.dart';
import 'package:kalahok/Model/ButtonWithIcons.dart';
import 'package:kalahok/Components/mob/MenuLanguageDesign.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/ContactPage.dart';
import 'package:kalahok/Screens/DataPrivacy.dart';
import 'package:kalahok/Screens/AboutPage.dart';
import 'package:kalahok/Screens/TextAndAudioPage.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _showMyDialog(context) async {
    Size size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: size.width*.6,
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
                        textAlign: TextAlign.center,style: textTitle(size.height*.03, Color(0xFF334089)),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(

                        controller: password,
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
              padding: const EdgeInsets.only(top:10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                    minWidth: size.width*.25,
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
                      Navigator.pop(context);
                    },
                    minWidth: size.width*.25,
                    height: 50,
                    child: Text(
                      'Submit',
                      style: textNextText(20,Colors.white),
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

      body: useMobLayout ? mobView3(context,0.04, 0.02) : tabView(),
    );
  }

  Widget mobView3(context, double titleHeight, double normalText) {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesign(title: 'Choose Language', subTitle: 'Select the language to get started',text1: 'Bicolano',text2: 'Ilocano',text3:'English',text4: 'Tagalog', widget: DataPrivacy(),widget2: DataPrivacy(),widget3: DataPrivacy(),widget4: DataPrivacy());
  }
  Widget tabView() {
    return Container();
    // final Orientation orientation = MediaQuery.of(context).orientation;
    // final Size size = MediaQuery.of(context).size;
    // return orientation==Orientation.portrait?mobView3(context):SingleChildScrollView(
    //   child: Padding(
    //     padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
    //     child: Column(
    //       children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.only(left: 30),
    //           child: sizedBox('Choose your language', 'Open Sans', size.height*0.045,FontWeight.w900, Colors.white,
    //               TextAlign.left),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 30),
    //           child: sizedBox('Select the language to get started', 'Source Sans 3', size.height*0.025,FontWeight.bold,
    //               Colors.white, TextAlign.left),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             padd(shortestSide: size.width/2.2, text: 'Bicolano', widget: DataPrivacy(), heightBut: size.height*.35, fS: size.height*0.045),
    //             padd(shortestSide: size.width/2.2, text: 'English', widget: DataPrivacy(), heightBut: size.height*.35, fS: size.height*0.045),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             padd(shortestSide: size.width/2.2, text: 'Ilocano', widget: DataPrivacy(), heightBut: size.height*.35, fS: size.height*0.045),
    //             padd(shortestSide: size.width/2.2, text: 'Tagalog', widget: DataPrivacy(), heightBut: size.height*.35, fS: size.height*0.045),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }



}

