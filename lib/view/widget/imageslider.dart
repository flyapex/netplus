import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:netplus/view/order.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlideTolet extends StatefulWidget {
  final double topPadding;
  final double hight;
  const ImageSlideTolet({
    this.topPadding = 0,
    Key? key,
    required this.hight,
  }) : super(key: key);

  @override
  State<ImageSlideTolet> createState() => _ImageSlideToletState();
}

class _ImageSlideToletState extends State<ImageSlideTolet> {
  final PageController pageController = PageController(initialPage: 0);
  // final UserController bannerController = Get.put(UserController());

  int _currentPage = 0;
  late Timer _timer;

  // Future getBannerAds() async {
  //   if (bannerController.fatchOneTime.value) {
  //     await bannerController.bannerApi();
  //   }
  //   // await bannerController.bannerApi();
  // }

  @override
  void initState() {
    // getBannerAds();
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    // bannerController.banneradsList.clear();
  }

  @override
  Widget build(BuildContext context) {
    var simlist = [
      'assets/icons/gp.svg',
      'assets/icons/airtel.svg',
      'assets/icons/bl.svg',
      'assets/icons/robi.svg',
      'assets/icons/tt.svg',
    ];
    return Container(
      height: widget.hight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: 7,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  // final Uri url =
                  //     Uri.parse(bannerController.banneradsList[index].url);

                  // if (!await launchUrl(
                  //   url,
                  //   mode: LaunchMode.externalApplication,
                  // )) {
                  //   throw Exception('Could not launch $url');
                  // }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        // ignore: prefer_const_constructors
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: const [
                            Colors.greenAccent,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset(
                                    simlist[Random().nextInt(4) + 0]),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Column(
                                  children: [
                                    Text(
                                      '২৫ জিবি ২০০ মিনিট',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '৳',
                                              style: TextStyle(
                                                fontSize: 30,
                                                height: 0.9,
                                                color: Color(0xffF0632E),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '৫৩৯ ',
                                              style: TextStyle(
                                                fontSize: 45,
                                                height: 0.9,
                                                color: Color(0xffF0632E),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    children: [
                                      const Text(
                                        '৩০ দিন |সারা বাংলাদেশ ',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black45,
                                        ),
                                      ),
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
                                    ],
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
              );
            },
            onPageChanged: (index) {},
          ),
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 7,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 7.5,
                    dotHeight: 7.5,
                    spacing: 10,
                    dotColor: Colors.black12,
                    activeDotColor: Colors.white,
                  ),
                  onDotClicked: (index) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
