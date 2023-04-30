import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kalahok/Components/mob/SurveyComponent.dart';
import 'package:kalahok/Components/tab/CategoricalSurveyTab.dart';
import 'package:kalahok/Model/Model.dart';
import 'package:kalahok/Model/constants.dart';

class StackDesignSurveyTab extends StatefulWidget {
  final Widget widget;
  final Widget widget2;
  const StackDesignSurveyTab({required this.widget, required this.widget2});

  @override
  State<StackDesignSurveyTab> createState() => _StackDesignSurveyTabState();
}

class _StackDesignSurveyTabState extends State<StackDesignSurveyTab> {
  final TextEditingController _controller =  TextEditingController();
  List<String> type = [];
  List<dynamic> text = [];
  List<int> and1=[];
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

  void getTypes() {
    get.demographicQuestions.length;
    int count = get.demographicQuestions.length;
    for (int i = 0; i < count; i++) {
      type.add(get.demographicQuestions[i].type);
    }

    text.length=get.demographicQuestions.length;

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
              return CategoricalPageTab(
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
    final response = await http
        .get(Uri.parse('http://192.168.1.9:1222/surveys/code/W1OJHE8F'));
    if (response.statusCode == 200) {
      get = Get.fromJson(json.decode(response.body));
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
    fetchSurvey().then((value) => getTypes());

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
          SurveyComponentThree(text: "Demographic Question"),
          Positioned(
            top: size.height * 0.17,
            left: size.width * 0.04,
            right: size.width * 0.04,
            bottom: size.height * 0.17,
            //Fetching survey
            child: FutureBuilder<Get>(
                future: fetchSurvey(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Text("loading"),
                    );
                  } else {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFF334089),width: 3)
                        ),
                        height:size.height*0.65,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              //display Text
                              Text(
                                get.demographicQuestions[indexQ].question,
                                textAlign: TextAlign.center,
                                style: textTitle(size.height*0.035, Colors.black),
                              ),
                              //If type is choice
                              get.demographicQuestions[indexQ].type == "choice" ?
                              Container(height: size.height*0.44, width: size.width*0.7,
                                child:  ListView.builder(
                                  itemCount: snapshot.data?.demographicQuestions[indexQ].choices?.length,
                                  itemBuilder: (context, indexChoice) {
                                    if (snapshot.data == null) {
                                      return Container(
                                        child: Text("loading"),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: MaterialButton(
                                        height: size.height*0.08,
                                        color:  TappedIndex==indexChoice?Color(0xFFE4C420):Color(0xFF334089),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        onPressed: () {
                                          var d = get.demographicQuestions[indexQ].choices?[indexChoice] ?? '';
                                          setState(() {
                                            text[indexQ]=d;
                                            TappedIndex = indexChoice;
                                            and1.add(indexChoice);
                                            nextQuestion();
                                          });
                                        },
                                        child: Text(get.demographicQuestions[indexQ].choices?[indexChoice] ?? '',style: TextStyle(color:Colors.white,fontSize: size.height*0.025),),
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
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: RatingBar.builder(
                                      minRating: 0,
                                      initialRating: rating,
                                      itemSize: size.height*0.1,
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
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Text('You rate $rating',style: textText(size.height*0.05, Colors.black),),
                                  ),
                                  MaterialButton(
                                    height: size.height*0.1,
                                    minWidth: size.width*0.5,
                                    color: Color(0xFF334089),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: Text("Add Rating",style: textText(size.height*0.035, Colors.white)),
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
                                    child: TextField(
                                      readOnly: true,
                                      controller:_controller,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Date',
                                          hintText: 'Press Icon Date',
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.date_range,color: Colors.black,),
                                            onPressed: () {
                                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2099)).then((value) =>
                                                  setState((){
                                                    if(_controller.text == value.toString()){
                                                      _controller.text = value.toString();
                                                    }else{
                                                      _controller.text = _dateTime.toString();
                                                    }
                                                  }));
                                            },
                                          )
                                      ),
                                    ),
                                  ),


                                  MaterialButton(
                                    height: size.height*0.1,
                                    minWidth: size.width*0.5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    color: Color(0xFF334089),
                                    child: Text("Add Date",style: textText(size.height*0.035, Colors.white),),
                                    onPressed: () {
                                      setState(() {

                                        text[indexQ]=_dateTime.toIso8601String();
                                        nextQuestion();
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
                                  MaterialButton(
                                    height: size.height*0.1,
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
                                    child: Text("Add Response",style: textText(size.height*0.035, Colors.white),),
                                  )
                                ],
                              ),
                              Text(text.isNotEmpty ? text.toString() : ""),
                              Text(type.toString()),
                              Text(and1.toString())
                            ],
                          ),
                        ),
                      ),
                    );
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
                        if(get.demographicQuestions[indexQ].type =="rating"){
                          rating = double.parse(text[indexQ].toString());
                        }else if(get.demographicQuestions[indexQ].type =="choice"){
                          TappedIndex = and1.last;
                          and1.removeLast();
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
                  child: Text('Back', style: textNextText(size.height * .03, Color(0xFF334089)),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

