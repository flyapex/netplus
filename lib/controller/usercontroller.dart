import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netplus/api/api.dart';
import 'package:netplus/model/receive.dart';
import 'package:netplus/model/send.dart';

class UserController extends GetxController {
  var userId = 0.obs;
  RxString name = 'xxx'.obs;
  RxString email = 'xxx@gmail.com'.obs;
  var imageUrl =
      'https://lh3.googleusercontent.com/a/ACg8ocI5SL5XCQO4EArybQ1127wXGS6x5kvrG2hNVpXBCfFsflY'
          .obs;

  var phone = ''.obs;
  var location = ''.obs;
  var status = 2.obs;
  late DateTime createdAt = ''.obs as DateTime;

  Future<int> userLogin(Newuser data) async {
    try {
      LoginModel response = await ApiService.userLogin(data);

      // ignore: unnecessary_null_comparison
      if (response != null) {
        var user = response.user;
        dbController.saveUserId(user.uid);
        dbController.saveToken(response.token);

        // dbController.saveStatus(user.status);

        userId.value = user.uid;
        name.value = user.name;
        email.value = user.email;
        imageUrl.value = user.imageUrl;
        phone.value = user.phone;
        location.value = user.location;
        status.value = user.status;
        createdAt = user.createdAt;
        snakberSuccess('Login successfully');
        return user.status;
      }
      return 3;
    } finally {}
  }

  var isLoading = false.obs;
  Future<int> getUserDetails() async {
    isLoading.value = true;
    try {
      LoginModel response = await ApiService.userDetails();
      // ignore: unnecessary_null_comparison
      if (response != null) {
        var user = response.user;
        dbController.saveUserId(user.uid);
        dbController.saveToken(response.token);
        userId.value = user.uid;
        name.value = user.name;
        email.value = user.email;
        imageUrl.value = user.imageUrl;
        phone.value = user.phone;
        location.value = user.location;
        status.value = user.status;
        createdAt = user.createdAt;
        return response.user.status;
      }

      return 3;
    } finally {
      isLoading.value = false;
    }
  }

  snakberSuccess(text) {
    return Get.snackbar(
      'You are awarsome',
      "",
      snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        maxLines: 1,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black.withOpacity(0.1),
      colorText: Colors.white,
      borderRadius: 4,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      maxWidth: 400.0,
      mainButton: TextButton(
        onPressed: () {
          // refreshkey.currentState!.refresh(
          //   draggingDuration: const Duration(milliseconds: 350),
          //   draggingCurve: Curves.easeOutBack,
          // );
          Get.back();
        },
        child: const Text(
          'Okay',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
