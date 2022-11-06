import 'package:flutter/material.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/LanguagePage.dart';
import 'package:kalahok/Screens/TextAndAudioPage.dart';

class DataPrivacy extends StatelessWidget {
  const DataPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(

      body: useMobLayout
          ? dataMob(context, .04, 0.025, .07, .4)
          : dataTab(orientation: orientation, context: context),
    );
  }

  Widget dataMob(context,double titleHeight,double textHeight,double heightBut, double widthBut){
  Size size = MediaQuery.of(context).size;
    return StackDesign(widget:
           Positioned(
            top: size.height * .045,
            left: size.width * .001,
            right: size.width * .001,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: <Widget>[
                  Text(
                    dataPrivacy,
                    style: textTitle(size.height*titleHeight, Color(0xFF334089)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      dataDesc,
                      style: dataPriv(
                          'Source Sans 3', size.height*textHeight, FontWeight.bold, Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      dataIncl,
                      style: dataPriv(
                        'Source Sans 3',
                        size.height*textHeight,
                        FontWeight.bold,
                        Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        sizedBox(dataBul1, 'Source Sans 3', size.height*textHeight, FontWeight.bold,
                            Colors.black, TextAlign.justify),
                        sizedBox(dataBul2, 'Source Sans 3', size.height*textHeight, FontWeight.bold,
                            Colors.black, TextAlign.justify),
                        sizedBox(dataBul3, 'Source Sans 3', size.height*textHeight, FontWeight.bold,
                            Colors.black, TextAlign.justify),
                        sizedBox(dataBul4, 'Source Sans 3', size.height*textHeight, FontWeight.bold,
                            Colors.black, TextAlign.justify),
                        sizedBox(dataBul5, 'Source Sans 3', size.height*textHeight, FontWeight.bold,
                            Colors.black, TextAlign.justify),
                      ],
                    ),
                  ),

                ],
              ),
            ),

      ),
      widget2: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: size.width*widthBut,
                height:  size.height*heightBut,
                child: Text(
                  'Disagree',
                  style: textNextText(size.height*.03,Color(0xFF334089)),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFE4C420),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const TextAudioPage();
                  }));
                },
                minWidth: size.width*widthBut,
                height: size.height*heightBut,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: const Color(0xFFFE4C420),
                child: Text(
                  'I Agree',
                  style: textNextText(size.height*.03,Color(0xFF334089)),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget dataTab({required Orientation orientation, context}) {
    Size size = MediaQuery.of(context).size;
    return orientation == Orientation.portrait
        ? dataMob(context, .034, 0.03, .07, .4)
        : dataMob(context, .06, 0.04, .08, .4);
  }
}
