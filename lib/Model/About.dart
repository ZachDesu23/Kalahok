// To parse this JSON data, do
//
// final about = aboutFromJson(jsonString);

import 'dart:convert';

About aboutFromJson(String str) => About.fromJson(json.decode(str));

String aboutToJson(About data) => json.encode(data.toJson());

class About {
  String title;
  String content;

  About({
    required this.title,
    required this.content,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}
