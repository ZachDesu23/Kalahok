import 'package:flutter/material.dart';
import 'package:kalahok/Components/mob/MenuLanguageDesign.dart';
import 'package:kalahok/Components/tab/MenuLanguageDesignTab.dart';
import 'package:kalahok/Screens/AboutPage.dart';
import 'package:kalahok/Screens/ContactPage.dart';
import 'package:kalahok/Screens/LanguagePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalahok/Screens/PartnersPage.dart';

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
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: useMobLayout ? mobView(context) : tabView(context),
    );
  }

  Widget mobView(context) {
    Size size = MediaQuery.of(context).size;
    return MenuLanguageDesign(
      title: 'Menu',
      subTitle: 'Tap the button to continue',
      faIcon: FaIcon(
        FontAwesomeIcons.circleInfo,
        color: Color(0xFFE4C420),
        size: size.height * 0.1,
      ),
      faIcon2: FaIcon(FontAwesomeIcons.squarePhoneFlip,
          color: Color(0xFFE4C420), size: size.height * 0.1),
      faIcon3: FaIcon(FontAwesomeIcons.handshake,
          color: Color(0xFFE4C420), size: size.height * 0.1),
      faIcon4: FaIcon(FontAwesomeIcons.filePen,
          color: Color(0xFFE4C420), size: size.height * 0.1),
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
      faIcon: FaIcon(
        FontAwesomeIcons.circleInfo,
        color: Color(0xFFE4C420),
        size: size.height * 0.2,
      ),
      faIcon2: FaIcon(FontAwesomeIcons.squarePhoneFlip,
          color: Color(0xFFE4C420), size: size.height * 0.2),
      faIcon3: FaIcon(FontAwesomeIcons.handshake,
          color: Color(0xFFE4C420), size: size.height * 0.2),
      faIcon4: FaIcon(FontAwesomeIcons.filePen,
          color: Color(0xFFE4C420), size: size.height * 0.2),
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
