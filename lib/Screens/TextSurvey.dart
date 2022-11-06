import 'package:flutter/material.dart';

class TextSurvey extends StatefulWidget {
  const TextSurvey({Key? key}) : super(key: key);

  @override
  State<TextSurvey> createState() => _TextSurveyState();
}

class _TextSurveyState extends State<TextSurvey> {


  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
