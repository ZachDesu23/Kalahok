import 'package:flutter/material.dart';
import 'package:kalahok/Components/mob/MenuLanguageDesign.dart';
import 'package:kalahok/Components/tab/MenuLanguageDesignTab.dart';
import 'package:kalahok/Screens/AboutPage.dart';
import 'package:kalahok/Screens/ContactPage.dart';
import 'package:kalahok/Screens/LanguagePage.dart';
import 'package:kalahok/Screens/PartnersPage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;

    return Scaffold(
      body: useMobLayout ? mobView(context) : tabView(context),
    );
  }

  Widget mobView(context) {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesign(
      title: 'Menu',
      subTitle: 'Tap the button to continue',
      faIcon: Image.asset('assets/image/About2.png',scale: 2.5,),
      faIcon2: Image.asset('assets/image/Contact2.png',scale: 2.5,),
      faIcon3: Image.asset('assets/image/Partnership2.png',width: size.width*0.25,),
      faIcon4: SvgPicture.asset('assets/image/Survey.svg',width: size.width*0.3,),
      text1: 'About',
      text2: 'Contact',
      text3: 'Partners',
      text4: 'Survey',
      widget: AboutPage(),
      widget2: ContactPage(),
      widget3: PartnerPage(),
      widget4: LanguagePage(),
    );
  }

  Widget tabView(context) {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesignTab(
      title: 'Menu',
      subTitle: 'Tap the button to continue',
      faIcon: Image.asset('assets/image/About2.png',scale: 1.5,),
      faIcon2: Image.asset('assets/image/Contact2.png',scale: 1.5,),
      faIcon3: Image.asset('assets/image/Partnership2.png',height: size.height*0.15,),
      faIcon4: SvgPicture.asset('assets/image/Survey.svg',height: size.height*0.15,),
      text1: 'About',
      text2: 'Contact',
      text3: 'Partners',
      text4: 'Survey',
      widget: AboutPage(),
      widget2: ContactPage(),
      widget3: PartnerPage(),
      widget4: LanguagePage(),
    );
  }
}
