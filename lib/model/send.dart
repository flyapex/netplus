// To parse this JSON data, do
//
//     final newuser = newuserFromJson(jsonString);

import 'dart:convert';

Newuser newuserFromJson(String str) => Newuser.fromJson(json.decode(str));

String newuserToJson(Newuser data) => json.encode(data.toJson());

class Newuser {
  String name;
  String email;
  String imageUrl;
  String fcm;

  Newuser({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.fcm,
  });

  factory Newuser.fromJson(Map<String, dynamic> json) => Newuser(
        name: json["name"],
        email: json["email"],
        imageUrl: json["image_url"],
        fcm: json["fcm"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "image_url": imageUrl,
        "fcm": fcm,
      };
}
