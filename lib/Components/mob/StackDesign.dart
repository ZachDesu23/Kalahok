import 'package:flutter/material.dart';

class StackDesign extends StatelessWidget {
  final Widget widget;
  final Widget widget2;
  const StackDesign({required this.widget, required this.widget2});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: size.height * .855,
              color: Colors.white,
            ),
            Container(
              height: size.height * .015,
              color: Color(0xFFE4C420),
            ),
            Container(
              height: size.height * .13,
              color: Color(0xFFFF334089),
            ),
          ],
        ),
        widget,
        widget2
      ],
    );
  }
}
