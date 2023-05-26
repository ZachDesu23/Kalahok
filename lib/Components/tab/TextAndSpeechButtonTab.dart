import 'package:flutter/material.dart';
import 'package:kalahok/Screens/TextSurveyTab/DemographicSurveyTab.dart';
import 'package:kalahok/Model/constants.dart';

class TSBTab extends StatelessWidget {
  final Widget onPress;
  final String text;
  final String text2;
  final Widget widget;
  final double fontSize;
  final double fontSizeNT;
  final double buttonHeight;
  const TSBTab({required this.onPress,required this.text, required this.text2,required this.widget, required this.fontSize, required this.fontSizeNT, required this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return onPress;
          },));

        },
        minWidth: 200,
        height: buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 60,right: 60),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text,
                        style:
                        dataPriv('Open Sans', fontSize, FontWeight.w800, Colors.black)),
                    Text(
                        text2,
                        style:
                        dataPriv('Source Sans 3', fontSizeNT, FontWeight.bold, Colors.black)),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                child: widget,
              ),

            ],
          ),
        ),
      ),
    );;
  }
}
