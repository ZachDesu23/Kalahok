import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.surveyCode,
    required this.answers,
  });

  String surveyCode;
  List<AnswerElement> answers;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    surveyCode: json["surveyCode"],
    answers: List<AnswerElement>.from(json["answers"].map((x) => AnswerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "surveyCode": surveyCode,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class AnswerElement {
  AnswerElement({
    required this.type,
    this.answer,
  });

  String type;
  dynamic answer;

  factory AnswerElement.fromJson(Map<String, dynamic> json) => AnswerElement(
    type: json["type"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "answer": answer,
  };
}
