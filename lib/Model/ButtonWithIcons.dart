import 'package:flutter/material.dart';
import 'package:kalahok/Model/constants.dart';


class padd extends StatelessWidget {
  const padd({
    Key? key,
    required this.shortestSide,
    required this.text,
    required this.widget,
    required this.heightBut,
    required this.fS,
  }) : super(key: key);


  final double shortestSide;
  final String text;
  final Widget widget;
  final double heightBut;
  final double fS;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: shortestSide,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));
            },
            height: heightBut,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    text,
                    style: dataPriv('Open Sans', fS, FontWeight.w700, Colors.black)
                ),

                const Icon(Icons.ac_unit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
