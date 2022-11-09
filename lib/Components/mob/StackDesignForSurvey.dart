import 'package:flutter/material.dart';

class StackDesignSurvey extends StatelessWidget {
  final Widget widget;
  final Widget widget2;
  const StackDesignSurvey({required this.widget, required this.widget2});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
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

          Positioned(
            top: size.height * .0,
            left: size.width * .0,
            right: size.width * .25,
            child: Container(
              height: size.height*0.162,
              decoration: BoxDecoration(
                  color: Color(0xFFE4C420),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(65))
              ),
            ),
          ),
          Positioned(
            top: size.height * .0,
            left: size.width * .0,
            right: size.width * .265,
            child: Container(
              height: size.height*0.155,
              decoration: BoxDecoration(
                  color: Color(0xFF334089),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(55))
              ),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('SAMPLE',style: TextStyle(color: Colors.white,fontSize: 20),textAlign:TextAlign.center)),
            ),
          ),
          Center(child: Text('asdnaosidnaskldnasdnaosidnasiodnasiodnasiodnasoidnasiodnasodinasiodnasodiasnodiansodiansodiansdioasndioasndioasdn'))
        ],
      ),
    );
  }
}
