import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalahok/Components/mob/DemographicSurvey.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Components/mob/TextAndSpeechButton.dart';
import 'package:kalahok/Components/tab/TextAndSpeechButtonTab.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/AboutPage.dart';
import 'package:kalahok/Screens/SpeechSurvey/DemographicsSpeechSurvey.dart';

class TextAudioPage extends StatelessWidget {
  const TextAudioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final useMobLayout = shortestSide <= 600;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF334089),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Text('Mode of Survey',
              style: useMobLayout?textTitle(size.height * 0.04, Colors.white):textTitle(size.height * 0.05, Colors.white)),
        ),
        body: useMobLayout
            ? mobView(context, 0.04, 0.025)
            : tabView(context, 0.03, 0.02));
  }

  Widget mobView(context, double titleHeight, double normalText) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
              child: Text('Select the desired mode for survey',
                  style: textText(size.height * normalText, Colors.white),
                  textAlign: TextAlign.start)),
        ),
        TSB(
            onPress: const DemographicsSpeechSurvey(widget: Text('1'), widget2: Text('2')),
            text: "Speech & Audio Collection",
            text2:
                'Speech and audio option is where the participant can listen to the survey question and their response will be recorded',
            widget: FaIcon(FontAwesomeIcons.microphoneLines,color:Color(0xFFE4C420),size: size.height*0.15,),
            fontSize: size.height * .034,
            fontSizeNT: size.height * .022,
            buttonHeight: size.height * .33),
        SizedBox(
          height: size.height * 0.02,
        ),
        TSB(
            onPress: const StackDesignSurvey(widget: Text('1'), widget2: Text('2')),
            text: 'Textual Data Questionnaire',
            text2:
                'Textual Data Questionaire is composed of questions and statements',
            widget:  FaIcon(FontAwesomeIcons.solidFileLines,color:Color(0xFFE4C420),size: size.height*0.15),
            fontSize: size.height * .034,
            fontSizeNT: size.height * .022,
            buttonHeight: size.height * .33),
      ],
    );
  }

  Widget tabView(context, double titleHeight, double normalText) {
    final Size size = MediaQuery.of(context).size;
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 20, 0),
                child: Container(
                    child: Text('Select the desired mode for survey',
                        style: textText(size.height * 0.03, Colors.white),
                        textAlign: TextAlign.start)),
              ),
              TSBTab(
                  onPress: const AboutPage(),
                  text: "Speech & Audio Collection",
                  text2:
                      'Speech and audio option is where the participant can listen to the survey question and their response will be recorded',
                  widget:  FaIcon(FontAwesomeIcons.microphoneLines,color:Color(0xFFE4C420),size: size.height*0.25),
                  fontSize: size.height * .035,
                  fontSizeNT: size.height * .03,
                  buttonHeight: size.height * .35),
              SizedBox(height: 10,),
              TSBTab(
                  onPress: const StackDesignSurvey(widget: Text('1'), widget2: Text('2')),
                  text: 'Textual Data Questionnaire',
                  text2:
                      'Textual Data Questionaire is composed of questions and statements',
                  widget:  FaIcon(FontAwesomeIcons.solidFileLines,color:Color(0xFFE4C420),size: size.height*0.25),
                  fontSize: size.height * .035,
                  fontSizeNT: size.height * .03,
                  buttonHeight: size.height * .35),
            ],
          );
  }
}
