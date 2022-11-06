
import 'package:flutter/material.dart';

TextStyle textTitle(double fontSize, Color color){
    return TextStyle(
        color: color,
        fontFamily: 'Open Sans',
        fontSize: fontSize,
        fontWeight: FontWeight.w900
    );
}
//(0xFF334089)

TextStyle textText(double fontSize, Color color){
    return TextStyle(
        color: color,
        fontFamily: 'Source Sans 3',
        fontSize: fontSize,
        fontWeight: FontWeight.bold
    );
}

TextStyle textNextText(double fontSize, Color color){
    return TextStyle(
        color: color,
        fontFamily: 'Open Sans',
        fontSize: fontSize,
    );
}

TextStyle dataPriv(String fontF,double fontSize,FontWeight fontWeight, Color color){
    return TextStyle(
        color: color,
        fontFamily: fontF,
        fontSize: fontSize,
        fontWeight: fontWeight);
}

SizedBox sizedBox(String des,String fontF, double fontSize,FontWeight fontWeight,Color color,TextAlign align){
    return SizedBox(
        width: double.infinity,
        child: Container(
            child: Text(des,style: dataPriv(fontF,fontSize,fontWeight,color),textAlign: align,),
        ),
    );
}

const String dataPrivacy = 'Data Protection and Privacy';
const String dataDesc = 'A Data Protection and Privacy Collection Statement is information provided at the time of collecting personal information (or as soon as practicable thereafter) that explains such things as the purpose of collecting the information. The provision of the privacy collection statement is a requirement of the Privacy and Data Protection Act 2014(VIC).';
const String dataIncl = 'Our Data Protection and Privacy Collection Statement include:';
const String dataBul1 = '\u2022 The purposes for which the personal information is collected.';
const String dataBul2 = '\u2022 The type of organization to whom the information may be disclosed.';
const String dataBul3 = '\u2022   any law requiring collection.                                                                 ';
const String dataBul4 = '\u2022 The main consequence if the information requested is not provided.';
const String dataBul5 = '\u2022   Any right to access personal information.                                                 ';
