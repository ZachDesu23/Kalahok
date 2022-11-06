import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Screens/DataPrivacy.dart';
import 'package:kalahok/Screens/LanguagePage.dart';

import '../Model/constants.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: useMobLayout? mobView(context) :Container(),
    );
  }

  Widget mobView(context){
    Size size = MediaQuery.of(context).size;
    return StackDesign(
      widget: Positioned(
        top: size.height * .045,
        left: size.width * .001,
        right: size.width * .001,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Contact',
                style: textTitle(size.height*0.04, Color(0xFF334089)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
              child: Text(
                'If you have inquiries, please send us a message and we will get back to you as soon as possible',
                style: dataPriv(
                    'Source Sans 3', size.height*0.025, FontWeight.bold,Color(0xFFadadad)),
                textAlign: TextAlign.justify,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0,bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone,size:size.height*0.09,color: Color(0xFF334089),),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text('091234567891',style: textText(size.height*0.035, Colors.black),),
                    ),
                    Icon(Icons.email,size:size.height*0.09,color: Color(0xFF334089)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text('kalahok@national-u.edu.ph',style: textText(size.height*0.035, Colors.black),),
                    ),
                    Icon(Icons.location_on,size:size.height*0.09,color: Color(0xFF334089)),
                    Text('Manila, Philippines',style: textText(size.height*0.035, Colors.black),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      widget2: Padding(
        padding: const EdgeInsets.only(top: 40,bottom: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            minWidth: size.width*0.9,
            height:  size.height*0.07,
            child: Text(
              'Back',
              style: textNextText(size.height*.03,Color(0xFF334089)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xFFE4C420),
          ),
        ),
      ),
    );
  }}
