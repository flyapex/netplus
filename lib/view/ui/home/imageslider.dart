import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/model/receive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlide extends StatefulWidget {
  final double hight;
  final List<OfferModel> data;
  const ImageSlide({
    Key? key,
    required this.hight,
    required this.data,
  }) : super(key: key);

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  final PageController pageController = PageController(initialPage: 0);
  final PostController postController = Get.put(PostController());

  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    print(widget.data.length);
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.data.length) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: postController.bannerLoding.value
            ? Colors.white
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.data.length,
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
                  // Get.bottomSheet(
                  //   NewOrderPopUp(data: widget.data[index]),
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
                  //   enterBottomSheetDuration: const Duration(milliseconds: 170),
                  // );
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
                                height: 50,
                                width: 50,
                                child: SvgPicture.asset(
                                  postController.getOperatorIcon(1),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${postController.numberToBangla(widget.data[index].gb)} জিবি ${postController.numberToBangla(widget.data[index].minute)} মিনিট',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: '৳',
                                              style: TextStyle(
                                                fontSize: 30,
                                                height: 0.9,
                                                color: Color(0xffF0632E),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${postController.numberToBangla(widget.data[index].mainPrice)} ',
                                              style: const TextStyle(
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
                                      Text(
                                        '${postController.numberToBangla(widget.data[index].duration)} দিন |${widget.data[index].offerLocation} ',
                                        style: const TextStyle(
                                          fontSize: 5,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: Get.width / 3.2,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFAB1C),
                                          borderRadius:
                                              BorderRadius.circular(500),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SmoothPageIndicator(
                controller: pageController,
                count: widget.data.length,
                effect: const ExpandingDotsEffect(
                  dotWidth: 7.5,
                  dotHeight: 7.5,
                  spacing: 5,
                  dotColor: Colors.black12,
                  activeDotColor: Colors.white,
                ),
                onDotClicked: (index) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
