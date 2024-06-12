import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/data/offer.dart';
import '../controller/usercontroller.dart';
import 'neworder.dart';
import 'widget/imageslider.dart';
import 'widget/note.dart';

class HomeX extends StatefulWidget {
  const HomeX({super.key});

  @override
  State<HomeX> createState() => _HomeXState();
}

class _HomeXState extends State<HomeX> {
  final NavbarController navbarController = Get.find();
  late Timer _timer;
  late Duration _countdownDuration;

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
      setState(() {
        if (_countdownDuration.inSeconds <= 0) {
          _timer.cancel();
          print('Countdown reached 0');
        } else {
          _countdownDuration = _countdownDuration - const Duration(seconds: 1);
        }
      });
      // if (_countdownDuration.inSeconds <= 0) {
      //   _timer.cancel();
      //   print('Countdown reached 0');
      // } else {
      //   _countdownDuration = _countdownDuration - const Duration(seconds: 1);
      // }
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
    // final PostController postController = Get.put(PostController());
    int hours = _countdownDuration.inHours % 24;
    int minutes = (_countdownDuration.inMinutes % 60);
    int seconds = (_countdownDuration.inSeconds % 60);
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     print("Facing Data");
      //     await postController.bannerApi();
      //   },
      // ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          controller: navbarController.scrollControllerHome,
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              //headerSilverBuilder only accepts slivers
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Note(
                          text:
                              '👀সিমে কোন লোন নেওয়া থাকলে অফার যাবে না লোনের টাকা কেটে যাবে!',
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // Get.bottomSheet(
                            //   const Order(),
                            //   elevation: 20.0,
                            //   enableDrag: true,
                            //   backgroundColor: Colors.white,
                            //   isScrollControlled: true,
                            //   ignoreSafeArea: true,
                            //   shape: const RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.only(
                            //       topLeft: Radius.circular(20.0),
                            //       topRight: Radius.circular(20.0),
                            //     ),
                            //   ),
                            //   enterBottomSheetDuration:
                            //       const Duration(milliseconds: 170),
                            // );
                          },
                          child: const ImageSlideTolet(
                            topPadding: 10.0,
                            hight: 160, //180
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      ],
                    ),
                  ),
                  const TabBar(
                    tabs: [
                      Tab(child: Text('GP')),
                      Tab(child: Text('Robi')),
                      Tab(child: Text('Airtel')),
                      Tab(child: Text('BL')),
                      // Tab(child: Text('Tele')),
                    ],
                  ),
                ],
              ),
            ),
          ],
          body: const TabBarView(
            children: [
              OfferList(operatorType: 1),
              OfferList(operatorType: 2),
              OfferList(operatorType: 3),
              OfferList(operatorType: 4),
              // OfferList(operatorType: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class OfferList extends StatefulWidget {
  final int operatorType;
  const OfferList({super.key, required this.operatorType});

  @override
  State<OfferList> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  PostController postController = Get.find();
  // if (postController.offerLists[operatorType]!.isEmpty) {
  //   postController.getOffer(operatorType);
  // }

  //  0: '০',
  //     1: '১',
  //     2: '২',
  //     3: '৩',
  //     4: '৪',
  //     5: '৫',
  //     6: '৬',
  //     7: '৭',
  //     8: '৮',
  //     9: '৯',
  final items = [
    "৭ দিন",
    "১৫ দিন",
    "৩০ দিন",
    "Unlimited দিন",
  ];
  List<String> selectedItem = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: FilterChip(
                        label: Text(e),
                        selected: selectedItem.contains(e),
                        onSelected: (bool value) {
                          if (selectedItem.contains(e)) {
                            selectedItem.remove(e);
                          } else {
                            selectedItem.add(e);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  )
                  .toList(),
            ).paddingOnly(left: 10),
          ),
          ListView.builder(
            padding: const EdgeInsets.only(left: 20, right: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            itemCount: 20,
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
                                  color:
                                      const Color(0xffEC008C).withOpacity(0.09),
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: SvgPicture.asset(
                                    postController
                                        .getOperatorIcon(widget.operatorType),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(color: Colors.transparent),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalDivider(
                                    color: Colors.transparent),
                                Text(
                                  '${postController.numberToBangla(gb)} জিবি ${postController.numberToBangla(minute)} মিনিট',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  // maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: '৳',
                                        style: TextStyle(
                                          height: 0.9,
                                          fontSize: 25,
                                          color: Color(0xffF0632E),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${postController.numberToBangla(mainPrice)} ',
                                        style: const TextStyle(
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
                                    const Icon(
                                      Feather.check_circle,
                                      size: 13,
                                      color: Colors.black54,
                                    ),
                                    const VerticalDivider(width: 4),
                                    Text(
                                      '৳${postController.numberToBangla(discountPrice)}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black54,
                                      ),
                                    ),
                                    const VerticalDivider(width: 8),
                                    const Icon(
                                      Feather.clock,
                                      size: 13,
                                      color: Colors.black54,
                                    ),
                                    const VerticalDivider(width: 4),
                                    Text(
                                      '${postController.numberToBangla(duration)} দিন',
                                      style: const TextStyle(
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
                                    borderRadius: BorderRadius.circular(1000),
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
    );
  }
}
