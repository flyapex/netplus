import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/usercontroller.dart';
import 'package:netplus/view/order.dart';

import 'widget/imageslider.dart';
import 'widget/note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NavbarController navbarController = Get.find();
  late Timer _timer;
  late Duration _countdownDuration;
  var simlist = [
    'assets/icons/gp.svg',
    'assets/icons/airtel.svg',
    'assets/icons/bl.svg',
    'assets/icons/robi.svg',
    'assets/icons/tt.svg',
  ];

  @override
  void initState() {
    navbarController.scrollControllerHome.addListener(() {
      if (navbarController.scrollControllerHome.offset >=
              navbarController.scrollControllerHome.position.maxScrollExtent &&
          !navbarController.scrollControllerHome.position.outOfRange) {
        print('bottom');
      }
      if (navbarController.scrollControllerHome.offset <=
              navbarController.scrollControllerHome.position.minScrollExtent &&
          !navbarController.scrollControllerHome.position.outOfRange) {
        print('top');
      }
    });
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    DateTime now = DateTime.now();
    DateTime targetTime = DateTime(now.year, now.month, now.day, 9, 0, 0);

    if (now.isAfter(targetTime)) {
      targetTime = targetTime.add(const Duration(days: 1));
    }

    _countdownDuration = targetTime.difference(now);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // setState(() {
      //   if (_countdownDuration.inSeconds <= 0) {
      //     _timer.cancel();
      //     print('Countdown reached 0');
      //   } else {
      //     _countdownDuration = _countdownDuration - const Duration(seconds: 1);
      //   }
      // });
      if (_countdownDuration.inSeconds <= 0) {
        _timer.cancel();
        print('Countdown reached 0');
      } else {
        _countdownDuration = _countdownDuration - const Duration(seconds: 1);
      }
    });
  }

  String _translateNumberToBangla(int number) {
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NavbarController navbarController = Get.find();
    // ignore: unused_local_variable
    UserController userController = Get.put(UserController());

    int hours = _countdownDuration.inHours % 24;
    int minutes = (_countdownDuration.inMinutes % 60);
    int seconds = (_countdownDuration.inSeconds % 60);

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: const AlwaysScrollableScrollPhysics(),
          controller: navbarController.scrollControllerHome,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Note(
                text:
                    '👀সিমে কোন লোন নেওয়া থাকলে অফার যাবে না লোনের টাকা কেটে যাবে!',
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    const Order(),
                    elevation: 20.0,
                    enableDrag: true,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    ignoreSafeArea: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    enterBottomSheetDuration: const Duration(milliseconds: 170),
                  );
                },
                child: const ImageSlideTolet(
                  topPadding: 10.0,
                  hight: 160, //180
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.09),
                            border: Border.all(
                              width: 1,
                              color: Colors.blue.withOpacity(0.09),
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset(
                                'assets/icons/gp.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Grameen Phone',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.09),
                            border: Border.all(
                              width: 1,
                              color: Colors.blue.withOpacity(0.09),
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset(
                                'assets/icons/robi.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Robi',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pink.withOpacity(0.09),
                            border: Border.all(
                              width: 1,
                              color: Colors.pink.withOpacity(0.09),
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: SvgPicture.asset(
                                'assets/icons/airtel.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Airtle',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.withOpacity(0.09),
                            border: Border.all(
                              width: 1,
                              color: Colors.orange.withOpacity(0.09),
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                'assets/icons/bl.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'banglalink',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff6AC537).withOpacity(0.09),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff717476).withOpacity(0.09),
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 43,
                              height: 43,
                              child: SvgPicture.asset(
                                'assets/icons/tt.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Talitalk',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 1,
                    color: Colors.black26,
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'নতুন অফার শুরু হবে',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF0632E),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 35,
                            width: Get.width / 9,
                            decoration: BoxDecoration(
                              color: const Color(0xff3D444E),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '${_translateNumberToBangla(hours)} h',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: Get.width / 9,
                            decoration: BoxDecoration(
                              color: const Color(0xff3D444E),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '${_translateNumberToBangla(minutes)} m',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: Get.width / 9,
                            decoration: BoxDecoration(
                              color: const Color(0xff3D444E),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '${_translateNumberToBangla(seconds)} s',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Treanding Now',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                // controller: navbarController.scrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          const Order(),
                          elevation: 20.0,
                          enableDrag: true,
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          ignoreSafeArea: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          enterBottomSheetDuration:
                              const Duration(milliseconds: 170),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black12,
                            width: 1,
                          ),
                          // boxShadow: const [
                          //   BoxShadow(color: Colors.black12, spreadRadius: 1.1),
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 13),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.09),
                                    border: Border.all(
                                      width: 1,
                                      color: const Color(0xffEC008C)
                                          .withOpacity(0.09),
                                    ),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: SvgPicture.asset(
                                          simlist[Random().nextInt(4) + 0]),
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(color: Colors.transparent),
                              const Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalDivider(color: Colors.transparent),
                                    Text(
                                      '২৫ জিবি ২০০ মিনিট',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '৳',
                                            style: TextStyle(
                                              height: 0.9,
                                              fontSize: 25,
                                              color: Color(0xffF0632E),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '৫৩৯ ',
                                            style: TextStyle(
                                              height: 0.9,
                                              fontSize: 30,
                                              color: Color(0xffF0632E),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Feather.check_circle,
                                          size: 13,
                                          color: Colors.black54,
                                        ),
                                        VerticalDivider(width: 4),
                                        Text(
                                          '৳৩৫২',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.black54,
                                          ),
                                        ),
                                        VerticalDivider(width: 8),
                                        Icon(
                                          Feather.clock,
                                          size: 13,
                                          color: Colors.black54,
                                        ),
                                        VerticalDivider(width: 4),
                                        Text(
                                          '৩০ দিন',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: Get.width / 3.2,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFAB1C),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'সারা বাংলাদেশ ',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
