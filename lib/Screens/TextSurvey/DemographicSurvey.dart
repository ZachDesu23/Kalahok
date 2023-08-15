import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kalahok/Screens/TextSurvey/CategoricalSurvey.dart';
import 'package:kalahok/Components/mob/SurveyComponent.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StackDesignSurvey extends StatefulWidget {
  final Widget widget;
  final Widget widget2;
  const StackDesignSurvey({super.key, required this.widget, required this.widget2});

  @override
  State<StackDesignSurvey> createState() => _StackDesignSurveyState();
}

class _StackDesignSurveyState extends State<StackDesignSurvey> {
  final TextEditingController _controller =  TextEditingController();
  final selectedIndexes = [];
  List type = [];
  List<dynamic> text = [];
  List and1=[];
  bool answerSelected = false;
  bool disable = false;
  bool date = false;
  int indexQ = 0;
  Get get = Get(
      id: 'id',
      code: 'code',
      language: 'language',
      title: 'title',
      description: '',
      demographicQuestions: [],
      categoricalQuestions: [],
      openEndedQuestions: []);
  double rating = 0;
  int ? group1Value;
  final DateTime _dateTime = DateTime.now();
  int TappedIndex = -1;
  late Future<Get> dataFuture;
  late AnimationController controller;


  void getTypes() {
    get.demographicQuestions.length;
    int count = get.demographicQuestions.length;
    print("HERE AT COUNT"+count.toString());
    int countChoices = 0;
    for (int i = 0; i < count; i++) {
      type.add(get.demographicQuestions[i].type);
      if(get.demographicQuestions[i].type=="choice"){
        text.add([]);
      }else{
        text.add(0);
      }
    }
    text.length=get.demographicQuestions.length;
    debugPrint(text.toString());
    and1 = List<int>.filled(text.length, -1);
    type.length=get.demographicQuestions.length;
  }

  void nextQuestion() {
    setState(() {
      if (indexQ < get.demographicQuestions.length - 1) {
        indexQ++;
        TappedIndex=-1;
      } else {
        setState(() {
          disable = true;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CategoricalPage(
                widget: Text(''),
                widget2: Text(''),
                demographicAnswer: text,
                demographicType: type,
              );
            },
          ));
        });
      }
    });
  }

  Future<Get> fetchSurvey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? code = prefs.getString('code');
    final response = await http.get(Uri.parse('$baseUrl/surveys/code/$code'));
    await Future.delayed(Duration(seconds: 2));
    if (response.statusCode == 200) {
      get = Get.fromJson(json.decode(response.body));
      getTypes();
      return Get.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to fetch');
    }
  }



  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    dataFuture = fetchSurvey();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(onPressed: (){
              setState(() {
                dataFuture = fetchSurvey();
              });
            },icon:  Icon(Icons.refresh,size: size.width*0.1),color: Colors.white,),
          ),

        ],

        title: Text('Demographic Question',style: TextStyle(fontSize: 25,color: Colors.white)),
        backgroundColor: Color(0xFF334089),

      ),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<Get>(
          future: dataFuture,
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Text("Loading");
              case ConnectionState.done:
              default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Container(
                  child: Text("$error"),
                );
              } else if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Question ${indexQ+1}/${snapshot.data?.demographicQuestions.length}',style: textTitle(size.width*0.067, Color(0xFF334089)),),
                      ),
                      LinearProgressIndicator(
                        value: indexQ/get.demographicQuestions.length,

                        color: Color(0xFF334089),
                        semanticsLabel: 'Linear progress indicator',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xFF334089),width: 3)
                          ),
                          height:size.height*0.75,
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                //display Text
                                Text(
                                  get.demographicQuestions[indexQ].question,
                                  textAlign: TextAlign.center,
                                  style: textTitle(size.width*0.04, Colors.black),
                                ),

                                //If type is choice
                                get.demographicQuestions[indexQ].type == "choice" && get.demographicQuestions[indexQ].multiple == true ?

                                Container(
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: ListView.builder(
                                          itemCount: snapshot.data?.demographicQuestions[indexQ].choices?.length,
                                          itemBuilder: (context, indexChoice) {
                                            if (snapshot.data == null) {
                                              return Container(
                                                child: Text("loading"),
                                              );
                                            }
                                            return Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      Checkbox(
                                                        value: text[indexQ].contains(get.demographicQuestions[indexQ].choices?[indexChoice]),
                                                        onChanged: (value) {
                                                          if(text[indexQ].contains(get.demographicQuestions[indexQ].choices?[indexChoice])){
                                                            text[indexQ].remove(get.demographicQuestions[indexQ].choices?[indexChoice]);
                                                          }else{
                                                            text[indexQ].add(get.demographicQuestions[indexQ].choices?[indexChoice]);
                                                          }
                                                          setState(() {
                                                          });
                                                        },
                                                        checkColor: Colors.greenAccent,
                                                        activeColor: Colors.black,
                                                      ),
                                                      Text(
                                                        get.demographicQuestions[indexQ].choices?[indexChoice] ?? '',style: TextStyle(color:Colors.black,fontSize: size.width*0.04),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: MaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              nextQuestion();
                                            });
                                          },
                                          minWidth: size.width * .4,
                                          height: size.height * .05,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          color: Color(0xFF334089),
                                          child: Text(
                                            'Add',
                                            style: textNextText(size.height * .03, Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ):
                                get.demographicQuestions[indexQ].type == "choice" ? Expanded(
                                  child: ListView.builder(
                                    itemCount: snapshot.data?.demographicQuestions[indexQ].choices?.length,
                                    itemBuilder: (context, indexChoice) {
                                      if (snapshot.data == null) {
                                        return Container(
                                          child: Text("loading"),
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                        child: MaterialButton(
                                          height: size.height*0.03,
                                          minWidth: size.width*0.5,
                                          color:  TappedIndex==indexChoice?Color(0xFFE4C420):Color(0xFF334089),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          onPressed: () {
                                            var d = get.demographicQuestions[indexQ].choices?[indexChoice] ?? '';
                                            setState(() {
                                              text[indexQ]=[d];
                                              TappedIndex = indexChoice;
                                              and1[indexQ]=indexChoice;
                                              debugPrint(text.toString());
                                              nextQuestion();
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(get.demographicQuestions[indexQ].choices?[indexChoice] ?? '',style: TextStyle(color:Colors.white,fontSize: size.width*0.04),),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                //If type is rating
                                    : get.demographicQuestions[indexQ].type == "rating"
                                    ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      child: RatingBar.builder(
                                        minRating: 0,
                                        initialRating: rating,
                                        itemBuilder: (BuildContext context, int index) {
                                          return const Icon(
                                            Icons.star,
                                            size: 100,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (double rating) {
                                          setState(() {
                                            this.rating = rating;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      child: Text('You rate $rating',style: textText(size.height*0.03, Colors.black),),
                                    ),
                                    MaterialButton(
                                      minWidth: size.width*0.5,
                                      color: Color(0xFF334089),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      child: Text("Add Rating",style: textText(size.height*0.02, Colors.white)),
                                      onPressed: () {
                                        setState(() {
                                          if (rating != 0) {
                                            text[indexQ]=rating;
                                            nextQuestion();
                                            rating=0;
                                          } else {

                                          }
                                        });
                                      },
                                    )
                                  ],
                                )
                                    : //If type is date
                                get.demographicQuestions[indexQ].type == "date"
                                    ? Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      child: TextFormField(
                                        readOnly: true,
                                        controller:_controller,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Enter Date',
                                            hintText: 'Press Icon Date',
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.date_range,color: Colors.black,),
                                              onPressed: () async{
                                                DateTime ? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1960), lastDate: DateTime(2099));

                                                if(pickedDate != null){
                                                  setState(() {
                                                    _controller.text = pickedDate.toIso8601String();
                                                  });
                                                }
                                                // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2099)).then((value) =>
                                                //     setState((){
                                                //       if(_controller.text == value.toString()){
                                                //         _controller.text = value.toString();
                                                //       }else{
                                                //         _controller.text = _dateTime.toString();
                                                //       }
                                                //     }));
                                              },
                                            )
                                        ),
                                      ),
                                    ),

                                    Text("selected date: ${_controller.text}",style: TextStyle(fontSize: 20),),
                                    MaterialButton(
                                      minWidth: size.width*0.5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      color: Color(0xFF334089),
                                      child: Text("Add Date",style: textText(size.height*0.02, Colors.white),),
                                      onPressed: () {
                                        setState(() {
                                          if (_controller.text.isNotEmpty) {
                                            text[indexQ]=DateTime.parse(_controller.text).toIso8601String();
                                            _controller.clear();
                                            answerSelected = true;
                                            nextQuestion();
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Text is empty"),
                                            ));
                                          }
                                          // text[indexQ]=_controller.text;
                                          // nextQuestion();
                                        });
                                      },
                                    )
                                  ],
                                )
                                    :
                                //If type is text
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Text',
                                            hintText: 'Enter Text',
                                          ),
                                          controller: _controller),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: MaterialButton(
                                        minWidth: size.width*0.5,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        color: Color(0xFF334089),
                                        onPressed: () {
                                          setState(() {
                                            if (_controller.text.isNotEmpty) {
                                              text[indexQ]=_controller.text;
                                              _controller.clear();
                                              answerSelected = true;
                                              nextQuestion();
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Text is empty"),
                                                  ));
                                            }
                                          });
                                        }
                                        ,
                                        child: Text("Add Response",style: textText(size.height*0.025, Colors.white),),
                                      ),
                                    )
                                  ],
                                ),
                                buildMaterialButton(context, size),

                                // Text(text.isNotEmpty ? text.toString() : ""),
                                // Text(type.toString()),
                                // Text(and1.toString())
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }else{
                return Text("No Data");
              }
            }

          }),
    );
  }

  MaterialButton buildMaterialButton(BuildContext context, Size size) {
    return MaterialButton(
                onPressed: () {
                  setState(() {
                    if (indexQ > 0) {
                      --indexQ;
                      if(get.demographicQuestions[indexQ].type =="rating"){
                        rating = double.parse(text[indexQ].toString());
                      }else if(get.demographicQuestions[indexQ].type =="choice"){
                        TappedIndex = and1[indexQ];

                      }else{
                        _controller.text = text[indexQ].toString();
                      }
                    }else{
                      Navigator.pop(context);
                    }
                  });

                },
                minWidth: size.width * .4,
                height: size.height * .07,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFE4C420),
                child: Text(
                  'Prev Question',
                  style: textNextText(size.height * .03, Color(0xFF334089)),
                ),
              );
  }
}


