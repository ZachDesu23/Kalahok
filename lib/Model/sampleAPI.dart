import 'dart:convert';

SampleApi sampleApiFromJson(String str) => SampleApi.fromJson(json.decode(str));

String sampleApiToJson(SampleApi data) => json.encode(data.toJson());

class SampleApi {
  SampleApi({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory SampleApi.fromJson(Map<String, dynamic> json) => SampleApi(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}