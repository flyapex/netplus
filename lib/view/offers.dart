import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/usercontroller.dart';
import 'home.dart';
import 'widget/note.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final NavbarController navbarController = Get.find();

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NavbarController navbarController = Get.find();
    // ignore: unused_local_variable
    UserController userController = Get.put(UserController());

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: navbarController.scrollControllerOffer,
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Note(
                          text:
                              '👀সিমে কোন লোন নেওয়া থাকলে অফার যাবে না লোনের টাকা কেটে যাবে!',
                        ),
                        // SizedBox(height: 20),
                        // Text(
                        //   'সাম্প্রতিক বিক্রি',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.black,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TabBar(
                      tabs: [
                        Tab(child: Text('এলাকা ভিত্তিক')),
                        Tab(child: Text('ফেমিলি')),
                        Tab(child: Text('সাম্প্রতিক বিক্রি')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                // controller: navbarController.scrollController,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Post(status: Random().nextInt(3) + 0);
                },
              ),
              const OfferList(operatorType: 1),
              const OfferList(operatorType: 2),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   // physics: const AlwaysScrollableScrollPhysics(),
      //   controller: navbarController.scrollControllerRecent,
      //   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const Note(
      //         text:
      //             '👀সিমে কোন লোন নেওয়া থাকলে অফার যাবে না লোনের টাকা কেটে যাবে!',
      //       ),
      //       const SizedBox(height: 20),
      //       const Text(
      //         'সাম্প্রতিক বিক্রি',
      //         style: TextStyle(
      //           fontSize: 12,
      //           color: Colors.black,
      //         ),
      //       ),
      //       ListView.builder(
      //         physics: const NeverScrollableScrollPhysics(),
      //         shrinkWrap: true,
      //         primary: false,
      //         // controller: navbarController.scrollController,
      //         itemCount: 4,
      //         itemBuilder: (context, index) {
      //           return Post(status: Random().nextInt(3) + 0);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
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

    // UserController userController = Get.put(UserController());
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        height: 100,
        // margin: const EdgeInsets.only(top: 15),
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
          padding: const EdgeInsets.only(right: 10),
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
                  // child: Center(
                  //   child: SizedBox(
                  //     child: Image(
                  //       image: NetworkImage(
                  //         userController.image.value,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://fastly.picsum.photos/id/256/200/200.jpg?hmac=MX3r8Dktr5b26lQqb5JB6sgLnCxSgt1KRm0F1eNDHCk'),
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
                        VerticalDivider(width: 8),
                        Text(
                          '0191665xxxx',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            decorationColor: Colors.black54,
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
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // const SizedBox(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 1),
                        child: getStatus(),
                      ),
                    ),

                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          '3m ago',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black38,
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
      ),
    );
  }
}
