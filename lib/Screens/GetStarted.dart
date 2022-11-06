import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/LanguagePage.dart';
import 'package:kalahok/Screens/Menu.dart';
import 'package:kalahok/Screens/TextAndAudioPage.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool mobUseLayout = shortestSide <=600;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: mobUseLayout?  buildStackMob(context,size):buildStackTab(context, size),
    );
  }

  Widget buildStackMob(context,Size size) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: size.height*.15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Kalahok',
              style: textTitle(size.height * 0.06, Color(0xFF334089)),
            ),
          ),
        ],
      ),
    Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width*.8,
            height: size.height*.06,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  Menu()
                ));

              },
              child:  Text('Get Started', style: textText(size.height*0.035, Colors.white)),
              color: Color(0xFFFB731C),
              textColor: Colors.white,
              elevation: 5,
            ),
          ),),
    )
    ]);
  }

  Widget buildStackTab(context,Size size){
    Orientation orientation = MediaQuery.of(context).orientation;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: size.height*.15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Kalahok',
              style: textTitle(size.height * 0.06, Color(0xFF334089)),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width*.8,
            height: size.height*.06,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    Menu()
                ));

              },
              child:  Text('Get Started', style: textText(size.height*0.035, Colors.white)),
              color: Color(0xFFFB731C),
              textColor: Colors.white,
              elevation: 5,
            ),
          ),),
      )
    ]);
  }
}
