import 'package:flutter/material.dart';

class SurveyComponent extends StatelessWidget {
  const SurveyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
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
    );
  }
}

class SurveyComponentTwo extends StatelessWidget {
  const SurveyComponentTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * .0,
      left: size.width * .0,
      right: size.width * .25,
      child: Container(
        height: size.height * 0.162,
        decoration: BoxDecoration(
          color: Color(0xFFE4C420),
          borderRadius:
          BorderRadius.only(bottomRight: Radius.circular(65)),
        ),
      ),
    );
  }
}

class SurveyComponentThree extends StatelessWidget {
  final String text;
  const SurveyComponentThree({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * .0,
      left: size.width * .0,
      right: size.width * .265,
      child: Container(
        height: size.height * 0.155,
        decoration: const BoxDecoration(
          color: Color(0xFF334089),
          borderRadius:
          BorderRadius.only(bottomRight: Radius.circular(55)),
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(radius: 30,),
                ),
                Flexible(
                  child: Text(text,
                      style: TextStyle(color: Colors.white, fontSize: size.width/20,fontFamily: 'Open Sans',fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
              ],
            )),
      ),
    );
  }
}
