// To parse this JSON data, do
//
//     final kaushalapi = kaushalapiFromJson(jsonString);

import 'dart:convert';

List<Kaushalapi> kaushalapiFromJson(String str) => List<Kaushalapi>.from(json.decode(str).map((x) => Kaushalapi.fromJson(x)));

String kaushalapiToJson(List<Kaushalapi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kaushalapi {
  int userId;
  int id;
  String title;
  String body;

  Kaushalapi({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Kaushalapi.fromJson(Map<String, dynamic> json) => Kaushalapi(
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

