import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:netplus/model/receive.dart';
import 'package:netplus/model/send.dart';

import '../controller/db_controller.dart';

// var baseUrl = 'http://109.123.234.150:4600/api';
var baseUrl = 'http://10.0.2.2:3002/api/buyer';

final dio = Dio();
DBController dbController = Get.put(DBController());
final globalOptions = Options(
  headers: {
    'Authorization': dbController.getToken(),
  },
);

void updateToken() {
  globalOptions.headers!['Authorization'] = dbController.getToken();
}

class ApiService {
  static Future userLogin(Newuser data) async {
    updateToken();

    final response = await dio.post(
      '$baseUrl/login',
      data: newuserToJson(data),
    );

    if (response.statusCode == 200) {
      return loginModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future userDetails() async {
    updateToken();
    final response = await dio.get(
      '$baseUrl/login',
      options: globalOptions,
    );

    if (response.statusCode == 200) {
      // print(response.data);
      return loginModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future getAllOffersPost() async {
    updateToken();
    final response = await dio.get(
      '$baseUrl/post',
      options: globalOptions,
    );

    if (response.statusCode == 200) {
      return offerModelFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }

  static Future newOrder(int offerId, String number) async {
    updateToken();
    final response = await dio.post(
      '$baseUrl/order',
      options: globalOptions,
      data: {"offer_id": offerId, "number": number},
    );

    // if (response.statusCode == 200) {
    //   return response.data['message'];
    // } else {
    //   return null;
    // }
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future getOrderHistory() async {
    updateToken();
    final response = await dio.get(
      '$baseUrl/order',
      options: globalOptions,
    );

    if (response.statusCode == 200) {
      return orderRecFromJson(jsonEncode(response.data));
    } else {
      return null;
    }
  }
}




// static Future banner() async {
  //   Response response = await dio.get(
  //     "$baseUrl/banner",
  //     queryParameters: {"total": 6},
  //   );

  //   if (response.statusCode == 200) {
  //     // print(jsonEncode(response.data));
  //     // return offerModelFromJson(jsonEncode(response.data));
  //   } else {
  //     return null;
  //   }
  // }

  // static Future getOffer(operatorType) async {
  //   Response response = await dio.get(
  //     "$baseUrl/offer",
  //     queryParameters: {"operatorType": operatorType},
  //   );

  //   print('$baseUrl/offer');
  //   print({"operatorType": operatorType});

  //   if (response.statusCode == 200) {
  //     // return offerModelFromJson(jsonEncode(response.data));
  //   } else {
  //     return null;
  //   }
  // }

  // static Future newOrder(
  //   int uid,
  //   int offerid,
  //   String number,
  //   String currentLocation,
  // ) async {
  //   Response response = await dio.post(
  //     "$baseUrl/neworder",
  //     data: {
  //       "uid": uid,
  //       "offer_id": offerid,
  //       "number": number,
  //       "current_location": currentLocation
  //     },
  //   );
  //   // print(response.data['offer']);
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // static Future getOrderHistory(uid) async {
  //   Response response = await dio.get(
  //     "$baseUrl/history/order",
  //     queryParameters: {"uid": uid},
  //   );

  //   if (response.statusCode == 200) {
  //     // print(jsonEncode(response.data));
  //     // return historyModelFromJson(jsonEncode(response.data));
  //   } else {
  //     return null;
  //   }
  // }