import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:netplus/controller/postcontroller.dart';

import 'widget/textinput.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 100),
      height: Get.height - 80,
      width: Get.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Expanded(
            child: OrderPage(),
          ),
        ],
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    var simlist = [
      'assets/icons/gp.svg',
      'assets/icons/airtel.svg',
      'assets/icons/bl.svg',
      'assets/icons/robi.svg',
      'assets/icons/tt.svg',
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'অফার কিনুন',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.withOpacity(0.09),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xffEC008C).withOpacity(0.09),
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
                      const VerticalDivider(color: Colors.transparent),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '২৫ জিবি ২০০ মিনিট',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffF0632E),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '৫৩৯ ',
                                  style: TextStyle(
                                    height: 0.9,
                                    fontSize: 30,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'টাকা',
                                  style: TextStyle(
                                    height: 0.9,
                                    fontSize: 27,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '৳৩৫২',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextInputBoxOnly(
                    topPadding: 30,
                    title: "১১ ডিজিটের নাম্বার *",
                    textType: TextInputType.number,
                    hintText: "Only 11 Digit Number",
                    controller: postController.number,
                    widthh: 2.35 / 2,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'লোকেশন',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      decorationColor: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  TextInputBoxOnly(
                    topPadding: 30,
                    title: "কুপন (যদি থাকে)",
                    textType: TextInputType.number,
                    hintText: "FREE2024",
                    controller: postController.number,
                    widthh: 2.35 / 2,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Get.height / 17,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Get.back();
                          Get.dialog(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
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
                                            const Text(
                                              'আপনার অফার রিকোয়েস্টটি আমরা পেয়েছি!',
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 3),
                                            const Text(
                                              '১০ মিনিটের আমাদের সাথে থাকার জন্য ধন্যবাদ🤝',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                child: Lottie.asset(
                                                  'assets/lottie/done.json',
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      foregroundColor:
                                                          const Color(
                                                              0xFFFFFFFF),
                                                      backgroundColor:
                                                          Colors.amber,
                                                      minimumSize:
                                                          const Size(0, 45),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: const Text(
                                                      'Okay',
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
                        },
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                'assets/icons/cart.svg',
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Buy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        elevation: 0.2,
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
