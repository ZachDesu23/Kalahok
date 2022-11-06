import 'package:flutter/material.dart';
import 'package:kalahok/Model/ButtonWithIcons.dart';
import 'package:kalahok/Components/mob/MenuLanguageDesign.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Components/mob/TextAndSpeechButton.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:kalahok/Screens/AboutPage.dart';
import 'package:kalahok/Screens/ContactPage.dart';
import 'package:kalahok/Screens/GetStarted.dart';
import 'package:kalahok/Screens/LanguagePage.dart';
import 'package:kalahok/Screens/TextAndAudioPage.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {



  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <=600;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: useMobLayout?mobView(context):mobView(context),
    );


  }

  Widget mobView(context) {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesign(title: 'Menu', subTitle: 'Tap the button to continue',text1: 'About',text2: 'Contact',text3:'Partners',text4: 'Survey',widget: AboutPage(),widget2: ContactPage(),widget3: Scaffold(),widget4: LanguagePage(),);
  }
}
