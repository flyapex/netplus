import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:netplus/api/api.dart';
import 'package:netplus/controller/usercontroller.dart';

class PostController extends GetxController {
  UserController userController = Get.put(UserController());
  final refreshkey = GlobalKey<CustomRefreshIndicatorState>();
  // final NavbarController navbarController = Get.find();
  TextEditingController number = TextEditingController();
  TextEditingController cupon = TextEditingController();
  var flagActiveFlag = false.obs;
  var numberFlag = false.obs;

  String numberToBangla(int number) {
    Map<int, String> banglaNumbers = {
      0: '০',
      1: '১',
      2: '২',
      3: '৩',
      4: '৪',
      5: '৫',
      6: '৬',
      7: '৭',
      8: '৮',
      9: '৯',
    };

    String banglaNumber = '';
    String numString = number.toString();
    for (int i = 0; i < numString.length; i++) {
      banglaNumber += banglaNumbers[int.parse(numString[i])]!;
    }
    return banglaNumber;
  }

  String getOperatorIcon(int val) {
    var simlist = [
      'assets/icons/gp.svg', //1
      'assets/icons/robi.svg', //2
      'assets/icons/airtel.svg', //3
      'assets/icons/bl.svg', //4
      'assets/icons/tt.svg', //5
    ];

    return simlist[val - 1];
  }

  var banneradsList = [].obs;
  var bannerLoding = true.obs;
  var fatchOneTime = true.obs;
  Future bannerApi() async {
    try {
      banneradsList.clear();
      bannerLoding(true);
      var response = await ApiService.banner();
      if (response != null) {
        banneradsList.addAll(response);
        bannerLoding(false);
      }
    } finally {
      fatchOneTime(false);
    }
  }

  // var offerLoading = true.obs;
  var offerLists = {
    1: [].obs,
    2: [].obs,
    3: [].obs,
    4: [].obs,
    5: [].obs,
  };

  getOffer(int operatorType) async {
    // offerLoading(true);
    try {
      var response = await ApiService.getOffer(operatorType);
      var offerList = offerLists[operatorType];

      if (response != null) {
        // offerList?.clear();
        offerList?.addAll(response);

        if (response.isEmpty) {
          return offerList;
        }
      }
    } finally {
      // offerLoading(false);
    }
  }

  void getGpOffer(int operatorType) {
    getOffer(operatorType);
  }

  newOrder(offerid) async {
    bool response = await ApiService.newOrder(
      userController.getUserID(),
      offerid,
      number.text,
      'Khulna',
    );

    // if (response) {}
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        response
                            ? 'আপনার অফার রিকোয়েস্টটি আমরা পেয়েছি!'
                            : 'User not found',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        response
                            ? '১০ মিনিট আমাদের সাথে থাকার জন্য ধন্যবাদ🤝'
                            : 'Contact Support 24/7',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: Lottie.asset(
                            response
                                ? 'assets/lottie/done.json'
                                : 'assets/lottie/404.json',
                            repeat: false,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFFFFFFFF),
                                backgroundColor:
                                    response ? Colors.amber : Colors.red,
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (response) {
                                  Get.back();
                                  // navbarController.selectedIndex = 2;
                                  // navbarController.pagecontroller.jumpToPage(2);
                                } else {
                                  Get.back();
                                  //fb page
                                }
                              },
                              child: Text(
                                response ? 'Okay' : 'Okay🤝',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  var historyList = [].obs;
  var historyLoding = true.obs;
  var fatchOneTimehistory = true.obs;
  Future getHistory() async {
    try {
      historyLoding(true);
      var response =
          await ApiService.getOrderHistory(userController.getUserID());
      if (response != null) {
        historyList.addAll(response);
        historyLoding(false);
      }
    } finally {
      fatchOneTimehistory(false);
    }
  }
}
