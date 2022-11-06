import 'package:flutter/material.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Components/mob/TextAndSpeechButton.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/AboutPage.dart';

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
              style: textTitle(size.height * 0.04, Colors.white)),
        ),
        body: useMobLayout
            ? mobView(context, 0.04, 0.025)
            : tabView(context, 0.04, 0.02));
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
            onPress: const AboutPage(),
            text: "Speech & Audio Collection",
            text2:
                'Speech and audio option is where the participant can listen to the survey question and their response will be recorded',
            fontSize: size.height * .034,
            fontSizeNT: size.height * .022,
            buttonHeight: size.height * .33),
        SizedBox(
          height: size.height * 0.02,
        ),
        TSB(
            onPress: const AboutPage(),
            text: 'Textual Data Questionnaire',
            text2:
                'Textual Data Questionaire is composed of questions and statements',
            fontSize: size.height * .034,
            fontSizeNT: size.height * .022,
            buttonHeight: size.height * .33),
      ],
    );
  }

  Widget tabView(context, double titleHeight, double normalText) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;
    return orientation == Orientation.portrait
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text('Mode of Survey',
                    style: textTitle(size.height * titleHeight, Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                    child: Text('Select the desired mode for survey',
                        style: textText(size.height * normalText, Colors.white),
                        textAlign: TextAlign.start)),
              ),
              TSB(
                  onPress: const AboutPage(),
                  text: "Speech & Audio Collection",
                  text2:
                      'Speech and audio option is where the participant can listen to the survey question and their response will be recorded',
                  fontSize: size.height * .04,
                  fontSizeNT: size.height * .022,
                  buttonHeight: size.height * .33),
              TSB(
                  onPress: const AboutPage(),
                  text: 'Textual Data Questionnaire',
                  text2:
                      'Textual Data Questionaire is composed of questions and statements',
                  fontSize: size.height * .04,
                  fontSizeNT: size.height * .022,
                  buttonHeight: size.height * .33),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text('Mode of Survey',
                    style: textTitle(size.height * 0.06, Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                    child: Text('Select the desired mode for survey',
                        style: textText(size.height * 0.04, Colors.white),
                        textAlign: TextAlign.start)),
              ),
              TSB(
                  onPress: const AboutPage(),
                  text: "Speech & Audio Collection",
                  text2:
                      'Speech and audio option is where the participant can listen to the survey question and their response will be recorded',
                  fontSize: size.height * .06,
                  fontSizeNT: size.height * .04,
                  buttonHeight: size.height * .33),
              TSB(
                  onPress: const AboutPage(),
                  text: 'Textual Data Questionnaire',
                  text2:
                      'Textual Data Questionaire is composed of questions and statements',
                  fontSize: size.height * .06,
                  fontSizeNT: size.height * .04,
                  buttonHeight: size.height * .33),
            ],
          );
  }
}
