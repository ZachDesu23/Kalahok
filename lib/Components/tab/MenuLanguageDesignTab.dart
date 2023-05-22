import 'package:flutter/material.dart';
import 'package:kalahok/Model/constants.dart';

class MenuLanguageDesignTab extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget faIcon,faIcon2,faIcon3,faIcon4;
  final Widget widget,widget2,widget3,widget4;
  final String text1,text2,text3,text4;
  const MenuLanguageDesignTab({required this.title, required this.subTitle,required this.faIcon, required this.faIcon2, required this.faIcon3, required this.faIcon4,required this.text1,required this.text2,required this.text3,required this.text4,required this.widget,required this.widget2,required this.widget3,required this.widget4,});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF334089),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: size.width*0.04,
        title: Text(title,style: textTitle(size.width*.055,Colors.white)),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50,top:30),
              child: sizedBox(subTitle, 'Source Sans 3', size.height*0.03, FontWeight.w800, Colors.white, TextAlign.left),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return widget;
                      },));

                    },
                    child: Container(
                        height: size.height*0.35,
                        width: size.width*0.45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: faIcon
                              ),
                              Text(text1,style: textTitle(size.height*0.04, Colors.black),textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return widget2;
                      },));


                    },
                    child: Container(
                        height: size.height*0.35,
                        width: size.width*0.45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: faIcon2
                              ),
                              Text(text2,style: textTitle(size.height*0.04, Colors.black),textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return widget3;
                      },));

                    },
                    child: Container(
                        height: size.height*0.35,
                        width: size.width*0.45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Align(
                          alignment: Alignment.center,

                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: faIcon3
                              ),
                              Text(text3,style: textTitle(size.height*0.04, Colors.black),textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return widget4;
                      },));

                    },
                    child: Container(
                        height: size.height*0.35,
                        width: size.width*0.45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: faIcon4
                              ),
                              Text(text4,style: textTitle(size.height*0.04, Colors.black),textAlign: TextAlign.center,)
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
