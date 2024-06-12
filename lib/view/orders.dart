import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/data/offer.dart';
import '../controller/navcontroller.dart';
import 'widget/note.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  NavbarController navbarController = Get.find();
  PostController postController = Get.find();

  @override
  void initState() {
    // if (postController.fatchOneTimehistory.value) {
    //   postController.getHistory();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomRefreshIndicator(
          key: postController.refreshkey,
          durations: const RefreshIndicatorDurations(
              completeDuration: Duration(milliseconds: 450)),
          // ignore: deprecated_member_use
          builder: MaterialIndicatorDelegate(
            backgroundColor: Colors.blueAccent,
            builder: (context, controller) {
              return SizedBox(
                child: LottieBuilder.asset(
                  'assets/lottie/ref.json',
                ),
              );
            },
          ),
          onRefresh: () async {
            // postController.historyList.clear();
            // postController.historyList.refresh();

            // postController.getHistory();
            // postController.historyList.sentToStream;
          },
          child: SingleChildScrollView(
            controller: navbarController.scrollControllerOrder,
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
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return const Post();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  // final HistoryModel data;
  const Post({
    super.key,
    // required this.data,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    // var max = 1;
    // var min = 0;
    // Random rnd = Random();

    var r = 2;

    getStatus() {
      if (r == 0) {
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

    getStatusTxt() {
      if (r == 0) {
        return 'Panding';
      } else {
        return 'Done';
      }
    }

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
                                child: SvgPicture.asset(
                                  postController.getOperatorIcon(r),
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
                              const VerticalDivider(color: Colors.transparent),
                              Text(
                                '${postController.numberToBangla(gb)} জিবি ${postController.numberToBangla(minute)} মিনিট',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              getStatus(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$offerLocation ',
                                    style: const TextStyle(
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
                                    child: SvgPicture.asset(
                                      postController.getOperatorIcon(r),
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
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          decoration:
                                              TextDecoration.lineThrough,
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  getStatus(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        offerLocation,
                                        style: const TextStyle(
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
                              'Number : ${0134567890}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.7),
                                decorationColor: Colors.black54,
                              ),
                            ),
                            Text(
                              // '8:15 10/10/2022',
                              'Status: ${getStatusTxt()}',
                              style: const TextStyle(
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
