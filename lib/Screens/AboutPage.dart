import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalahok/Components/mob/Button.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Model/About.dart';
import 'package:http/http.dart' as http;
import '../Model/constants.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  late Future<About> futureAbout;

  Future<About> fetchAbout()async{
    final response = await http.get(Uri.parse('https://kalahok-api-development.up.railway.app/information/about-us'));
    if(response.statusCode == 200){
      return About.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load about data');
    }

  }

  @override
  void initState() {
    super.initState();
    futureAbout = fetchAbout();
}

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: useMobLayout? mobView(context) :tabView(orientation: orientation,context: context),
    );
  }

  Widget mobView(context){
    Size size = MediaQuery.of(context).size;
      return StackDesign(
        widget: Positioned(
          top: size.height * .045,
          left: size.width * .001,
          right: size.width * .001,
          child: FutureBuilder<About>(
            future: futureAbout,
            builder: (context, snapshot) {
             if(snapshot.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'About',
                        style: textTitle(size.height*0.04, Color(0xFF334089)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10,left: 20),
                      child: Text(
                        snapshot.data!.title,
                        style: dataPriv(
                            'Source Sans 3', size.height*0.025, FontWeight.bold,Color(0xFFadadad)),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(90.0),
                            child: CircleAvatar(radius: size.height*0.1,),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(snapshot.data!.content,textAlign: TextAlign.justify,style: textText(22,Colors.black),),
                        ),

                      ],
                    ),
                  ],
                );
             }else if(snapshot.hasError){
               return Text('${snapshot.error}');
              }
             return Positioned(
                 top: size.height * .4,
                 left: size.width * .45,
                 child: Text("Loading"));
            },
          )
        ),
        widget2: Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonComponent(action: () {
              Navigator.pop(context);
            },
            width: 0.9,
            height: 0.07,),
            // child: MaterialButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   minWidth: size.width*0.9,
            //   height:  size.height*0.07,
            //   child: Text(
            //     'Back',
            //     style: textNextText(size.height*.03,Color(0xFF334089)),
            //   ),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15.0),
            //   ),
            //   color: Color(0xFFE4C420),
            // ),
          ),
        ),
      );
  }

  Widget tabView({required Orientation orientation,context}){
    Size size = MediaQuery.of(context).size;
    return StackDesign(
      widget: Positioned(
        top: size.height * .045,
        left: size.width * .001,
        right: size.width * .001,
        child: FutureBuilder<About>(
          future: futureAbout,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'About',
                      style: textTitle(size.height*0.06, Color(0xFF334089)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 20),
                    child: Text(
                      snapshot.data!.title,
                      style: dataPriv(
                          'Source Sans 3', size.height*0.03, FontWeight.bold,Color(0xFFadadad)),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: CircleAvatar(radius: size.height*0.15,),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(snapshot.data!.content,textAlign: TextAlign.justify,style: textText(size.height*0.03,Colors.black),),
                        ),

                      ],
                    ),
                  ),
                ],
              );
            }else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return Positioned(
                top: size.height * .4,
                left: size.width * .45,
                child: Text("Loading"));
          },
        )
      ),
      widget2: Padding(
        padding: const EdgeInsets.only(top: 40,bottom: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            minWidth: size.width*0.9,
            height:  size.height*0.07,
            child: Text(
              'Back',
              style: textNextText(size.height*.03,Color(0xFF334089)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xFFE4C420),
          ),
        ),
      ),
    );
  }
}

