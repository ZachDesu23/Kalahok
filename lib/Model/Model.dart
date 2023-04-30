import 'dart:convert';

Get getFromJson(String str) => Get.fromJson(json.decode(str));

String getToJson(Get data) => json.encode(data.toJson());

class Get {
  Get({
    required this.id,
    required this.code,
    required this.language,
    required this.title,
    required this.description,
    required this.demographicQuestions,
    required this.categoricalQuestions,
    required this.openEndedQuestions,

  });

  String id;
  String code;
  String language;
  String title;
  String description;
  List<Question> demographicQuestions;
  List<Question> categoricalQuestions;
  List<OpenEndedQuestion> openEndedQuestions;

  factory Get.fromJson(Map<String, dynamic> json) => Get(
    id: json["_id"],
    code: json["code"],
    language: json["language"],
    title: json["title"],
    description: json["description"],
    demographicQuestions: List<Question>.from(json["demographicQuestions"].map((x) => Question.fromJson(x))),
    categoricalQuestions: List<Question>.from(json["categoricalQuestions"].map((x) => Question.fromJson(x))),
    openEndedQuestions: List<OpenEndedQuestion>.from(json["openEndedQuestions"].map((x) => OpenEndedQuestion.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "language": language,
    "title": title,
    "description": description,
    "demographicQuestions": List<dynamic>.from(demographicQuestions.map((x) => x.toJson())),
    "categoricalQuestions": List<dynamic>.from(categoricalQuestions.map((x) => x.toJson())),
    "openEndedQuestions": List<dynamic>.from(openEndedQuestions.map((x) => x.toJson())),

  };
}

class Question {
  Question({
    required this.type,
    required this.question,
    required this.multiple,
    required this.choices,
    required this.levels,
  });

  String type;
  String question;
  bool multiple;
  List<String>? choices;
  int levels;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    type: json["type"]??" ",
    question: json["question"]??" ",
    multiple: json["multiple"] ?? false,
    choices: json["choices"] == null ? null : List<String>.from(json["choices"].map((x) => x)),
    levels: json["levels"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "question": question,
    "multiple": multiple ?? false,
    "choices": choices == null ? null : List<dynamic>.from(choices!.map((x) => x)),
    "levels": levels ?? 0,
  };
}

class OpenEndedQuestion {
  OpenEndedQuestion({
    required this.type,
    required this.question,
  });

  String type;
  String question;

  factory OpenEndedQuestion.fromJson(Map<String, dynamic> json) => OpenEndedQuestion(
    type: json["type"],
    question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "question": question,
  };
}
