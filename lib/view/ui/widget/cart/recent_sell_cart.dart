import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/model/receive.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecentSell extends StatefulWidget {
  final ScrollController controller;
  const RecentSell({
    super.key,
    required this.controller,
  });

  @override
  State<RecentSell> createState() => _RecentSellState();
}

class _RecentSellState extends State<RecentSell> {
  PostController postController = Get.find();

  late List<OfferModel> data = [];
  late List<OfferModel> sortedData = [];

  final Map<String, int> durationMap = {
    "৭ দিন": 7,
    "১৫ দিন": 15,
    "৩০ দিন": 30,
    "Unlimited দিন": -1,
  };

  final items = [
    "৭ দিন",
    "১৫ দিন",
    "৩০ দিন",
    "Unlimited দিন",
  ];
  List<String> selectedItem = [];
  void sortData() {
    print('Selected Items: $selectedItem');

    if (selectedItem.isNotEmpty) {
      // Convert selected items to corresponding durations
      List<int> selectedDurations = selectedItem.map((item) {
        if (item == "Unlimited দিন") {
          return -1; // Handle unlimited duration
        } else {
          return durationMap[item]!;
        }
      }).toList();

      // Sort data based on closest match to selected durations
      sortedData = List.from(data);
      sortedData.sort((a, b) {
        int minDistA = selectedDurations
            .map((d) => (a.duration - d).abs())
            .reduce((curr, next) => curr < next ? curr : next);
        int minDistB = selectedDurations
            .map((d) => (b.duration - d).abs())
            .reduce((curr, next) => curr < next ? curr : next);
        return minDistA.compareTo(minDistB);
      });
    } else {
      sortedData = List.from(data);
    }

    print('Filtered Data Length: ${sortedData.length}');
    setState(() {});
  }

  void _animateToIndex() {
    widget.controller.animateTo(
      -1000,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  getStatus(status) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // widget.controller.jumpTo(widget.controller.position.maxScrollExtent);
          _animateToIndex();
        },
        child: const Icon(Feather.chevron_up),
      ),
      body: SingleChildScrollView(
        controller: widget.controller,
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
              itemCount: sortedData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: () {
                      // Get.bottomSheet(
                      //   OrderConfirm(data: data[index]),
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
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const VerticalDivider(
                                      color: Colors.transparent),
                                  Text(
                                    '${postController.numberToBangla(sortedData[index].gb)} জিবি ${postController.numberToBangla(sortedData[index].minute)} মিনিট',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
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
                                              '${postController.numberToBangla(sortedData[index].mainPrice)} ',
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
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      padding: const EdgeInsets.only(
                                          right: 10, bottom: 1),
                                      child: getStatus(data[index].status),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Text(
                                        '${timeago.format(sortedData[index].time, locale: 'en_short')} Ago',
                                        style: const TextStyle(
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
