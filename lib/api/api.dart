import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:netplus/model/model.dart';

var baseUrl = 'http://109.123.234.150:4600/api';
// var baseUrl = 'http://10.0.2.2:3000/api';

final dio = Dio();

class ApiService {
  static Future banner() async {
    Response response = await dio.get(
      "$baseUrl/banner",
      queryParameters: {"total": 6},
    );

    if (response.statusCode == 200) {
      return offerModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future getOffer(operatorType) async {
    Response response = await dio.get(
      "$baseUrl/offer",
      queryParameters: {"operatorType": operatorType},
    );

    if (response.statusCode == 200) {
      return offerModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future newOrder(
    int uid,
    int offerid,
    String number,
    String currentLocation,
  ) async {
    Response response = await dio.post(
      "$baseUrl/neworder",
      data: {
        "uid": uid,
        "offer_id": offerid,
        "number": number,
        "current_location": currentLocation
      },
    );
    // print(response.data['offer']);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future getOrderHistory(uid) async {
    Response response = await dio.get(
      "$baseUrl/history/order",
      queryParameters: {"uid": uid},
    );

    if (response.statusCode == 200) {
      return historyModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }
}
