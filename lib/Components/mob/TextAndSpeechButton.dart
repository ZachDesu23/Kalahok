import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalahok/Components/mob/demograpicSurvey.dart';
import 'package:kalahok/Model/constants.dart';

class TSB extends StatelessWidget {
  final Widget onPress;
  final String text;
  final String text2;
  final Widget widget;
  final double fontSize;
  final double fontSizeNT;
  final double buttonHeight;
  const TSB({required this.onPress,required this.text, required this.text2, required this.widget, required this.fontSize, required this.fontSizeNT, required this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return StackDesignSurvey(widget: Text('1'), widget2: Text('2'));
          },));

        },
        minWidth: 200,
        height: buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(text,
                  style:
                  dataPriv('Open Sans', fontSize, FontWeight.w800, Colors.black)),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        text2,
                        style:
                        dataPriv('Source Sans 3', fontSizeNT, FontWeight.bold, Colors.black)),
                  ),
                   widget
                ],
              ),

            ],
          ),
        ),
      ),
    );;
  }
}
