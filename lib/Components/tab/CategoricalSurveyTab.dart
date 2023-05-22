import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kalahok/Components/mob/SurveyComponent.dart';
import 'package:kalahok/Components/tab/OpenEndedSurveyTab.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoricalPageTab extends StatefulWidget {
  final List demographicAnswer;
  final List demographicType;
  final Widget widget;
  final Widget widget2;
  const CategoricalPageTab(
      {required this.widget,
      required this.widget2,
      required this.demographicAnswer,
      required this.demographicType});

  @override
  State<CategoricalPageTab> createState() => _CategoricalPageTabState();
}

class _CategoricalPageTabState extends State<CategoricalPageTab> {
  final TextEditingController _controller = TextEditingController();
  List type = [];
  List<dynamic> text = [];
  List and1=[];
  int tappedIndex = -1;
  String? d;
  bool answerSelected = false;
  bool disable = false;
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
  final DateTime _dateTime = DateTime.now();
  late Future<Get> dataFuture;

  void getTypes() {
    get.categoricalQuestions.length;
    int count2 = get.categoricalQuestions.length;
    for (int i = 0; i < count2; i++) {
      type.add(get.categoricalQuestions[i].type);
    }
    text.length=get.categoricalQuestions.length;
    and1 = List<int>.filled(text.length, -1);
    type.length=get.categoricalQuestions.length;
  }


  void nextQuestion() {
    setState(() {
      if (indexQ < get.categoricalQuestions.length - 1) {
        indexQ++;
        tappedIndex=-1;
      } else {
        setState(() {
          disable = true;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return OpenEndedPageTab(
                  widget: Text(""),
                  widget2: Text(""),
                  demographicAnswer: widget.demographicAnswer,
                  demographicType: widget.demographicType,
                  categoricalType: type,
                  categoricalAnswer: text);
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
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: <Widget>[
          SurveyComponent(),
          SurveyComponentTwo(),
          SurveyComponentThree(text: "Categorical Question"),
          Positioned(
              top: size.height * .07,
              left: size.width * .8,
              right: size.width * .07,
              child: IconButton(onPressed: (){
                setState(() {
                  dataFuture = fetchSurvey();
                });
              },icon:  Icon(Icons.refresh,size: size.width*0.12),color: Color(0xFF334089),)),
          Positioned(
            top: size.height * 0.17,
            left: size.width * 0.04,
            right: size.width * 0.04,
            bottom: size.height * 0.17,
            child: FutureBuilder<Get>(
                future: dataFuture,
                builder: (context, snapshot) {
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
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xFF334089),width: 3)
                            ),
                            height:size.height*0.8,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(get.categoricalQuestions[indexQ].question,
                                    textAlign: TextAlign.center,
                                    style: textTitle(size.width*0.04, Colors.black),),
                                  get.categoricalQuestions[indexQ].type == "choice" && get.categoricalQuestions[indexQ].multiple == true ?
                                  Container(
                                    height: 400,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: ListView.builder(
                                            itemCount: snapshot.data?.categoricalQuestions[indexQ].choices?.length,
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
                                                          value: text[indexQ].contains(get.categoricalQuestions[indexQ].choices?[indexChoice]),
                                                          onChanged: (value) {
                                                            if(text[indexQ].contains(get.categoricalQuestions[indexQ].choices?[indexChoice])){
                                                              text[indexQ].remove(get.categoricalQuestions[indexQ].choices?[indexChoice]);
                                                            }else{
                                                              text[indexQ].add(get.categoricalQuestions[indexQ].choices?[indexChoice]);
                                                            }
                                                            setState(() {

                                                            });
                                                          },
                                                          checkColor: Colors.greenAccent,
                                                          activeColor: Colors.black,
                                                        ),
                                                        Text(
                                                          get.categoricalQuestions[indexQ].choices?[indexChoice] ?? '',style: TextStyle(color:Colors.black,fontSize: size.width*0.04),
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
                                        MaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              nextQuestion();
                                            });
                                          },
                                          minWidth: size.width * .4,
                                          height: size.height * .07,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          color: Color(0xFF334089),
                                          child: Text(
                                            'Add',
                                            style: textNextText(size.height * .03, Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):get.categoricalQuestions[indexQ].type == "choice"
                                      ? Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data?.categoricalQuestions[indexQ].choices?.length,
                                      itemBuilder: (context, indexChoice) {
                                        if (snapshot.data == null) {
                                          return Container(
                                            child: Text("loading"),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                          child: MaterialButton(
                                            height: size.height*0.04,
                                            minWidth: size.width*0.5,
                                            color:  tappedIndex==indexChoice?Color(0xFFE4C420):Color(0xFF334089),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            onPressed: () {
                                              var d = get.categoricalQuestions[indexQ].choices?[indexChoice] ?? '';
                                              setState(() {
                                                text[indexQ]=[d];
                                                tappedIndex = indexChoice;
                                                and1[indexQ]=indexChoice;
                                                nextQuestion();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(get.categoricalQuestions[indexQ].choices?[indexChoice] ?? '',style:TextStyle(color: Colors.white,fontSize: size.width*0.04)),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ) : get.categoricalQuestions[indexQ].type == "rating"
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
                                        height: size.width*0.1,
                                        minWidth: size.width*0.5,
                                        color:  Color(0xFF334089),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        child: Text("Add Rating",style: textText(size.width*0.05, Colors.white)),
                                        onPressed: () {
                                          setState(() {
                                            if (rating != 0) {
                                              text[indexQ]=rating;
                                              nextQuestion();
                                            } else {

                                            }
                                          });
                                        },

                                      )
                                    ],
                                  )
                                      : get.categoricalQuestions[indexQ].type == "date"
                                      ? Column(
                                    children: <Widget>[
                                      TextField(
                                        readOnly: true,
                                        controller:_controller,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Date',
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
                                      Text("selected date: ${_controller.text}",style: TextStyle(fontSize: 20),),
                                      MaterialButton(
                                        height: size.width*0.1,
                                        minWidth: size.width*0.5,
                                        color:  Color(0xFF334089),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        child: Text("Add Date",style: textText(size.width*0.05, Colors.white),),
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
                                      : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                              border: OutlineInputBorder(),
                                              labelText: 'Text',
                                              hintText: 'Enter Text',
                                                hintStyle: TextStyle(fontSize: 30)
                                            ),
                                            maxLines: 4,
                                            style: TextStyle(fontSize: 30),
                                            controller: _controller),
                                      ),
                                      MaterialButton(
                                        minWidth: size.width*0.5,
                                        color:  Color(0xFF334089),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        onPressed: () {
                                          setState(() {
                                            if (_controller.text.isNotEmpty) {
                                              text[indexQ]=_controller.text;
                                              _controller.clear();
                                              answerSelected = true;
                                              nextQuestion();
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text("Text is empty"),
                                              ));
                                            }
                                          });
                                        },
                                        child: Text("Add Response"),
                                      )
                                    ],
                                  ),
                                  // Text("baba demoType"),
                                  // Text(widget.demographicType.toString()),
                                  // Text(widget.demographicAnswer.isNotEmpty ? widget.demographicAnswer.toString() : ""),
                                  // Text("baba categoType"),
                                  // Text(text.isNotEmpty ? text.toString() : ""),
                                  // Text(type.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Text("No Data");
                      }
                  }
                }),
          ),
          Positioned(
            top: size.height * .88,
            left: 10,
            right: 10,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (indexQ > 0) {
                        --indexQ;
                        if(get.categoricalQuestions[indexQ].type =="rating"){
                          rating = double.parse(text[indexQ].toString());
                        }else if(get.categoricalQuestions[indexQ].type =="choice"){
                          tappedIndex = and1[indexQ];
                        }else{
                          _controller.text = text[indexQ].toString();
                        }
                      } else {

                        Navigator.pop(context);
                      }
                    });
                    _controller.text;
                  },
                  minWidth: size.width * .4,
                  height: size.height * .07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFE4C420),
                  child: Text(
                    'Back',
                    style: textNextText(size.height * .03, Color(0xFF334089)),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
