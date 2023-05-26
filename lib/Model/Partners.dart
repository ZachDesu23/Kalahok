import 'dart:convert';

Partners partnersFromJson(String str) => Partners.fromJson(json.decode(str));

String partnersToJson(Partners data) => json.encode(data.toJson());

class Partners {
  List<Doc> docs;

  Partners({
    required this.docs,
  });

  factory Partners.fromJson(Map<String, dynamic> json) => Partners(
    docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
  };
}

class Doc {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Doc({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    id: json["_id"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
