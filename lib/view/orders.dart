import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../controller/navcontroller.dart';
import 'widget/note.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarController navbarController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        controller: navbarController.scrollControllerRecent,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Note(
                text:
                    '✅ অর্ডার করার ১০ মিনিট এর মধ্যে অর্ডার কন্ফার্ম হয়ে যাবে!, সাথে থাকার জন্য ধন্যবাদ🤝',
              ),
              const SizedBox(height: 15),
              const Text(
                'History',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Post(status: Random().nextInt(3) + 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  final int status;
  const Post({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    getStatus() {
      if (status == 1) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Center(
            child: Icon(
              FontAwesome.refresh,
              color: Colors.white,
              size: 30,
            ),
          ),
        );
      } else {
        return Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Center(
            child: Icon(
              FontAwesome.check,
              color: Colors.white,
              size: 30,
            ),
          ),
        );
      }
    }

    var simlist = [
      'assets/icons/gp.svg',
      'assets/icons/airtel.svg',
      'assets/icons/bl.svg',
      'assets/icons/robi.svg',
      'assets/icons/tt.svg',
    ];
    var number = simlist[Random().nextInt(4) + 0];

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ExpandableNotifier(
        child: ExpandableButton(
          child: Column(
            children: [
              Expandable(
                theme: const ExpandableThemeData(
                  animationDuration: Duration(milliseconds: 200),
                  sizeCurve: Curves.easeInOut,
                ),
                collapsed: Container(
                  height: 100,
                  // margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    // boxShadow: const [
                    //   BoxShadow(color: Colors.black12, spreadRadius: 1.1),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
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
                                color: Colors.blue.withOpacity(0.09),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                // child: SvgPicture.asset(
                                //   'assets/icons/gp.svg',
                                // ),
                                child: SvgPicture.asset(number),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      decoration: TextDecoration.lineThrough,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              getStatus(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'সারা বাংলাদেশ ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  ExpandableButton(
                                    child: const Icon(
                                      Feather.chevron_down,
                                      size: 18,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                expanded: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, spreadRadius: 1.1),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
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
                                    color: Colors.blue.withOpacity(0.09),
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: SvgPicture.asset(number),
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  getStatus(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'সারা বাংলাদেশ! ',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      ExpandableButton(
                                        child: const Icon(
                                          Feather.chevron_up,
                                          size: 18,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: double.infinity,
                        // margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Number : 01318728056',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.7),
                                decorationColor: Colors.black54,
                              ),
                            ),
                            const Text(
                              // '8:15 10/10/2022',
                              'Status: Panding',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
