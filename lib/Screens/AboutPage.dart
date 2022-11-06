import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Screens/DataPrivacy.dart';
import 'package:kalahok/Screens/LanguagePage.dart';

import '../Model/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: useMobLayout? mobView(context) :tabView(orientation: orientation,context: context),
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
                  'About',
                  style: textTitle(size.height*0.04, Color(0xFF334089)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10,left: 20),
                child: Text(
                  'What is Kalahok?',
                  style: dataPriv(
                      'Source Sans 3', size.height*0.025, FontWeight.bold,Color(0xFFadadad)),
                  textAlign: TextAlign.justify,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(90.0),
                    child: CircleAvatar(radius: size.height*0.1,),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Kalahok is an inclusive, deliverative, and multilingual eParticipation toolkit that has a more efficient and user-friendly interface to engage in. It create real-time data analytics for user to find on-the-spot meaning and value in their application',textAlign: TextAlign.justify,style: textText(22,Colors.black),),
                  ),

                ],
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
  }

  Widget tabView({required Orientation orientation,context}){
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
                'About',
                style: textTitle(size.height*0.04, Color(0xFF334089)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10,left: 20),
              child: Text(
                'What is Kalahok?',
                style: dataPriv(
                    'Source Sans 3', size.height*0.025, FontWeight.bold,Color(0xFFadadad)),
                textAlign: TextAlign.justify,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(90.0),
                  child: CircleAvatar(radius: size.height*0.1,),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Kalahok is an inclusive, deliverative, and multilingual eParticipation toolkit that has a more efficient and user-friendly interface to engage in. It create real-time data analytics for user to find on-the-spot meaning and value in their application',textAlign: TextAlign.justify,style: textText(22,Colors.black),),
                ),

              ],
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
    );;
  }
}
