// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  User user;
  String token;

  LoginModel({
    required this.user,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  int uid;
  String name;
  String email;
  String imageUrl;
  String phone;
  String location;
  String fcm;
  int status;
  DateTime createdAt;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.location,
    required this.fcm,
    required this.status,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["image_url"],
        phone: json["phone"],
        location: json["location"],
        fcm: json["fcm"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "image_url": imageUrl,
        "phone": phone,
        "location": location,
        "fcm": fcm,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

List<OfferModel> offerModelFromJson(String str) =>
    List<OfferModel>.from(json.decode(str).map((x) => OfferModel.fromJson(x)));

String offerModelToJson(List<OfferModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferModel {
  int offerId;
  int sellerId;
  int offerModelOperator;
  int gb;
  int minute;
  int mainPrice;
  int discountPrice;
  int duration;
  List<String> offerLocation;
  String pack;
  int click;
  int status;
  DateTime time;

  OfferModel({
    required this.offerId,
    required this.sellerId,
    required this.offerModelOperator,
    required this.gb,
    required this.minute,
    required this.mainPrice,
    required this.discountPrice,
    required this.duration,
    required this.offerLocation,
    required this.pack,
    required this.click,
    required this.status,
    required this.time,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        offerId: json["offer_id"],
        sellerId: json["seller_id"],
        offerModelOperator: json["operator"],
        gb: json["gb"],
        minute: json["minute"],
        mainPrice: json["main_price"],
        discountPrice: json["discount_price"],
        duration: json["duration"],
        offerLocation: List<String>.from(json["offer_location"].map((x) => x)),
        pack: json["pack"],
        click: json["click"],
        status: json["status"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "seller_id": sellerId,
        "operator": offerModelOperator,
        "gb": gb,
        "minute": minute,
        "main_price": mainPrice,
        "discount_price": discountPrice,
        "duration": duration,
        "offer_location": List<dynamic>.from(offerLocation.map((x) => x)),
        "pack": pack,
        "click": click,
        "status": status,
        "time": time.toIso8601String(),
      };
}
// To parse this JSON data, do
//
//     final offerModelSingle = offerModelSingleFromJson(jsonString);

List<OfferModelSingle> offerModelSingleFromJson(String str) =>
    List<OfferModelSingle>.from(
        json.decode(str).map((x) => OfferModelSingle.fromJson(x)));

String offerModelSingleToJson(List<OfferModelSingle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferModelSingle {
  int offerId;
  int sellerId;
  int offerModelSingleOperator;
  int gb;
  int minute;
  int mainPrice;
  int discountPrice;
  int duration;
  String offerLocation;
  String pack;
  int click;
  int status;
  DateTime time;

  OfferModelSingle({
    required this.offerId,
    required this.sellerId,
    required this.offerModelSingleOperator,
    required this.gb,
    required this.minute,
    required this.mainPrice,
    required this.discountPrice,
    required this.duration,
    required this.offerLocation,
    required this.pack,
    required this.click,
    required this.status,
    required this.time,
  });

  factory OfferModelSingle.fromJson(Map<String, dynamic> json) =>
      OfferModelSingle(
        offerId: json["offer_id"],
        sellerId: json["seller_id"],
        offerModelSingleOperator: json["operator"],
        gb: json["gb"],
        minute: json["minute"],
        mainPrice: json["main_price"],
        discountPrice: json["discount_price"],
        duration: json["duration"],
        offerLocation: json["offer_location"],
        pack: json["pack"],
        click: json["click"],
        status: json["status"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "seller_id": sellerId,
        "operator": offerModelSingleOperator,
        "gb": gb,
        "minute": minute,
        "main_price": mainPrice,
        "discount_price": discountPrice,
        "duration": duration,
        "offer_location": offerLocation,
        "pack": pack,
        "click": click,
        "status": status,
        "time": time.toIso8601String(),
      };

  void add(Map<String, dynamic> newOffer) {}
}
// To parse this JSON data, do
//
//     final orderRec = orderRecFromJson(jsonString);

List<OrderRec> orderRecFromJson(String str) =>
    List<OrderRec>.from(json.decode(str).map((x) => OrderRec.fromJson(x)));

String orderRecToJson(List<OrderRec> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderRec {
  int orderId;
  int orderRecOperator;
  int gb;
  int minute;
  int mainPrice;
  int discountPrice;
  int duration;
  List<String> offerLocation;
  String pack;
  String number;
  int status;
  int payment;
  DateTime time;

  OrderRec({
    required this.orderId,
    required this.orderRecOperator,
    required this.gb,
    required this.minute,
    required this.mainPrice,
    required this.discountPrice,
    required this.duration,
    required this.offerLocation,
    required this.pack,
    required this.number,
    required this.status,
    required this.payment,
    required this.time,
  });

  factory OrderRec.fromJson(Map<String, dynamic> json) => OrderRec(
        orderId: json["order_id"],
        orderRecOperator: json["operator"],
        gb: json["gb"],
        minute: json["minute"],
        mainPrice: json["main_price"],
        discountPrice: json["discount_price"],
        duration: json["duration"],
        offerLocation: List<String>.from(json["offer_location"].map((x) => x)),
        pack: json["pack"],
        number: json["number"],
        status: json["status"],
        payment: json["payment"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "operator": orderRecOperator,
        "gb": gb,
        "minute": minute,
        "main_price": mainPrice,
        "discount_price": discountPrice,
        "duration": duration,
        "offer_location": List<dynamic>.from(offerLocation.map((x) => x)),
        "pack": pack,
        "number": number,
        "status": status,
        "payment": payment,
        "time": time.toIso8601String(),
      };
}
