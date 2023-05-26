import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalahok/Components/mob/Button.dart';
import 'package:kalahok/Components/mob/StackDesign.dart';
import 'package:kalahok/Model/ContactUs.dart';
import 'package:http/http.dart' as http;

import '../Model/constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {


  late Future<ContactUs> futureContactUs;

  Future<ContactUs> fetchContactUs()async{
    final response = await http.get(Uri.parse('$baseUrl/information/contact-us'));
    if(response.statusCode == 200){
      return ContactUs.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load about data');
    }

  }

  @override
  void initState() {
    super.initState();
    futureContactUs = fetchContactUs();
  }


  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobLayout = shortestSide <= 600;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: useMobLayout? mobView(context) :tabView(context),
    );
  }

  Widget mobView(context){
    Size size = MediaQuery.of(context).size;
    return StackDesign(
      widget: Positioned(
        top: size.height * .045,
        left: size.width * .001,
        right: size.width * .001,
        child: FutureBuilder<ContactUs>(
          future: futureContactUs,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Contact',
                      style: textTitle(size.height*0.04, Color(0xFF334089)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
                    child: Text(
                      'If you have inquiries, please send us a message and we will get back to you as soon as possible',
                      style: dataPriv(
                          'Source Sans 3', size.height*0.025, FontWeight.bold,Color(0xFFadadad)),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70.0,bottom: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.phone,size:size.height*0.09,color: Color(0xFF334089),),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Text(snapshot.data!.phoneNumber,style: textText(size.height*0.035, Colors.black),),
                          ),
                          Icon(Icons.email,size:size.height*0.09,color: Color(0xFF334089)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Text(snapshot.data!.email,style: textText(size.height*0.035, Colors.black),),
                          ),
                          Icon(Icons.location_on,size:size.height*0.09,color: Color(0xFF334089)),
                          Text(snapshot.data!.address,style: textText(size.height*0.035, Colors.black),),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else if(snapshot.hasError){
              return Positioned(
                  top: size.height * .4,
                  left: size.width * .45,
                  child: Text('${snapshot.error}'));
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
          child:  ButtonComponent(action: () {
            Navigator.pop(context);
          },
            width: 0.9,
            height: 0.07,),
        ),
      ),
    );
  }

  Widget tabView(context){
    Size size = MediaQuery.of(context).size;
    return StackDesign(
      widget: Positioned(
        top: size.height * .045,
        left: size.width * .001,
        right: size.width * .001,
        child: FutureBuilder<ContactUs>(
          future: futureContactUs,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Contact',
                      style: textTitle(size.height*0.06, Color(0xFF334089)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
                    child: Text(
                      'If you have inquiries, please send us a message and we will get back to you as soon as possible',
                      style: dataPriv(
                          'Source Sans 3', size.height*0.03, FontWeight.bold,Color(0xFFadadad)),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150.0,bottom: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              Icon(Icons.phone,size:size.height*0.15,color: Color(0xFF334089),),
                              Text(snapshot.data!.phoneNumber,style: textText(size.height*0.035, Colors.black),),

                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.email,size:size.height*0.15,color: Color(0xFF334089)),
                              Text(snapshot.data!.email,style: textText(size.height*0.035, Colors.black),),

                            ],
                          ),

                          Column(
                            children: [
                              Icon(Icons.location_on,size:size.height*0.15,color: Color(0xFF334089)),
                              Text(snapshot.data!.address,style: textText(size.height*0.035, Colors.black),),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              );
            }else if(snapshot.hasError){
              return Positioned(
                  top: size.height * .4,
                  left: size.width * .45,
                  child: Text('${snapshot.error}'));
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
          child:  ButtonComponent(action: () {
            Navigator.pop(context);
          },
            width: 0.9,
            height: 0.07,),
        ),
      ),
    );
  }
}
