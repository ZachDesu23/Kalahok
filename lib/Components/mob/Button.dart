import 'package:flutter/material.dart';
import 'package:kalahok/Model/constants.dart';

typedef Action = void Function();

class ButtonComponent extends StatelessWidget {
  final Action action;
  final double width;
  final double height;
  const ButtonComponent({Key? key, required this.action, required this.width,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: action,
      // width 0.9 height 0.07 tablet
      // width
      minWidth: size.width*width,
      height:  size.height*height,
      child: Text(
        'Back',
        style: textNextText(size.height*.03,Color(0xFF334089)),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Color(0xFFE4C420),
    );
  }
}
