import 'package:flutter/material.dart';
import 'package:kalahok/Components/mob/Button.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Model/constants.dart';

class PartnerPage extends StatelessWidget {
  const PartnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: useMobLayout
          ? mobView(context)
          : tabView(orientation: orientation, context: context),
    );
  }

  Widget mobView(context) {
    Size size = MediaQuery.of(context).size;
    return StackDesign(
      widget: Positioned(
        top: size.height * .045,
        left: size.width * .001,
        right: size.width * .001,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Partners',
                style: textTitle(size.height * 0.04, Color(0xFF334089)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: Text(
                'Identified partner and collaborators of Kalahok',
                style: dataPriv('Source Sans 3', size.height * 0.024,
                    FontWeight.bold, Color(0xFFadadad)),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/ched.png',
                          height: size.height * 0.15,
                        ),
                        Image.asset(
                          'assets/image/denr.png',
                          height: size.height * 0.15,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/doh.png',
                          height: size.height * 0.15,
                        ),
                        Image.asset(
                          'assets/image/dost.png',
                          height: size.height * 0.15,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                          'assets/image/dswd.png',
                          height: size.height * 0.14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset('assets/image/NDRRMC.png',
                            height: size.height * 0.2, fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      widget2: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child:  ButtonComponent(action: () {
            Navigator.pop(context);
          },
            width: 0.9,
            height: 0.07,),
        ),
      ),
    );
  }

  Widget tabView({required Orientation orientation, context}) {
    Size size = MediaQuery.of(context).size;
    return StackDesign(
      widget: Positioned(
        top: size.height * .045,
        left: size.width * .001,
        right: size.width * .001,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Partners',
                style: textTitle(size.height * 0.06, Color(0xFF334089)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: Text(
                'Identified partner and collaborators of Kalahok',
                style: dataPriv('Source Sans 3', size.height * 0.03,
                    FontWeight.bold, Color(0xFFadadad)),
                textAlign: TextAlign.justify,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        'assets/image/ched.png',
                        height: size.height * 0.25,
                      ),
                      Image.asset(
                        'assets/image/denr.png',
                        height: size.height * 0.25,
                      ),
                      Image.asset('assets/image/NDRRMC.png',
                          height: size.height * 0.3, fit: BoxFit.fill),
                      Image.asset(
                        'assets/image/dost.png',
                        height: size.height * 0.25,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      'assets/image/dswd.png',
                      height: size.height * 0.25,fit: BoxFit.fitWidth
                    ),
                    Image.asset(
                      'assets/image/doh.png',
                      height: size.height * 0.25,
                    ),
                    Image.asset(
                      'assets/image/neda.png',
                      height: size.height * 0.25,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      widget2: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child:  ButtonComponent(action: () {
            Navigator.pop(context);
          },
            width: 0.9,
            height: 0.07,),
        ),
      ),
    );
    ;
  }
}
