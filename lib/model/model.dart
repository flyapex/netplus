import 'dart:convert';

NotesModel notesModelFromJson(String str) =>
    NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  final int nid;
  final String note;
  final int type;
  final DateTime time;

  NotesModel({
    required this.nid,
    required this.note,
    required this.type,
    required this.time,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        nid: json["nid"],
        note: json["note"],
        type: json["type"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "nid": nid,
        "note": note,
        "type": type,
        "time": time.toIso8601String(),
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
  int operatorType;
  int gb;
  int minute;
  int mainPrice;
  int discountPrice;
  int duration;
  String location;
  int click;
  String offerType;
  DateTime time;

  OfferModel({
    required this.offerId,
    required this.operatorType,
    required this.gb,
    required this.minute,
    required this.mainPrice,
    required this.discountPrice,
    required this.duration,
    required this.location,
    required this.click,
    required this.offerType,
    required this.time,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        offerId: json["offer_id"],
        operatorType: json["operatorType"],
        gb: json["gb"],
        minute: json["minute"],
        mainPrice: json["main_price"],
        discountPrice: json["discount_price"],
        duration: json["duration"],
        location: json["location"],
        click: json["click"],
        offerType: json["offerType"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "operatorType": operatorType,
        "gb": gb,
        "minute": minute,
        "main_price": mainPrice,
        "discount_price": discountPrice,
        "duration": duration,
        "location": location,
        "click": click,
        "offerType": offerType,
        "time": time.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(
    json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  final int orderId;
  final int uid;
  final int offerId;
  final int operatorType;
  final int gb;
  final int minute;
  final int mainPrice;
  final int discountPrice;
  final int duration;
  final String offerLocation;
  final String offerType;
  final String number;
  final String currentLocation;
  final int status;
  final DateTime time;

  HistoryModel({
    required this.orderId,
    required this.uid,
    required this.offerId,
    required this.operatorType,
    required this.gb,
    required this.minute,
    required this.mainPrice,
    required this.discountPrice,
    required this.duration,
    required this.offerLocation,
    required this.offerType,
    required this.number,
    required this.currentLocation,
    required this.status,
    required this.time,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        orderId: json["order_id"],
        uid: json["uid"],
        offerId: json["offer_id"],
        operatorType: json["operatorType"],
        gb: json["gb"],
        minute: json["minute"],
        mainPrice: json["main_price"],
        discountPrice: json["discount_price"],
        duration: json["duration"],
        offerLocation: json["offer_location"],
        offerType: json["offerType"],
        number: json["number"],
        currentLocation: json["current_location"],
        status: json["status"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "uid": uid,
        "offer_id": offerId,
        "operatorType": operatorType,
        "gb": gb,
        "minute": minute,
        "main_price": mainPrice,
        "discount_price": discountPrice,
        "duration": duration,
        "offer_location": offerLocation,
        "offerType": offerType,
        "number": number,
        "current_location": currentLocation,
        "status": status,
        "time": time.toIso8601String(),
      };
}
