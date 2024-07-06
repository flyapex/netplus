import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/model/receive.dart';

class OfferAreaCart extends StatefulWidget {
  final ScrollController controller;
  final List<OfferModelSingle> data;
  const OfferAreaCart({
    super.key,
    required this.controller,
    required this.data,
  });

  @override
  State<OfferAreaCart> createState() => _OfferAreaCartState();
}

class _OfferAreaCartState extends State<OfferAreaCart>
    with TickerProviderStateMixin {
  PostController postController = Get.find();

  late List<OfferModelSingle> sortedData = [];

  final List<String> areaMap = [
    "ঢাকা",
    "চট্টগ্রাম",
    "রাজশাহী",
    "খুলনা",
    "সিলেট",
    "বরিশাল",
    "রংপুর",
    "ময়মনসিংহ",
  ];
  List<String> selectedAreaItem = [];

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
      List<int> selectedDurations = selectedItem.map((item) {
        if (item == "Unlimited দিন") {
          return -1;
        } else {
          return durationMap[item]!;
        }
      }).toList();

      List<String> selectedAreas =
          selectedAreaItem.isNotEmpty ? selectedAreaItem : areaMap;

      sortedData = List.from(widget.data
          .where((item) => selectedAreas.contains(item.offerLocation)));

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
      sortedData = List.from(widget.data.where((item) =>
          selectedAreaItem.isEmpty ||
          selectedAreaItem.contains(item.offerLocation)));
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

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  void scrollAnimation() {
    widget.controller.addListener(() {
      if (widget.controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _controller.reverse();
      } else if (widget.controller.position.userScrollDirection ==
          ScrollDirection.forward) {
        _controller.forward();
      }
    });
  }

  @override
  void initState() {
    scrollAnimation();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
    // print('-------------data Length: ${widget.data.length}');
    sortedData = List.from(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SlideTransition(
        position: _offsetAnimation,
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          onPressed: () {
            _animateToIndex();
          },
          child: const Icon(Feather.chevron_up),
        ).paddingOnly(bottom: 30, right: 16),
      ),
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: areaMap
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: FilterChip(
                          label: Text(e),
                          selected: selectedAreaItem.contains(e),
                          onSelected: (bool value) {
                            setState(() {
                              if (selectedAreaItem.contains(e)) {
                                selectedAreaItem.remove(e);
                              } else {
                                selectedAreaItem.add(e);
                              }
                              sortData();
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ).paddingOnly(left: 10),
            ),
            Visibility(
              visible: selectedAreaItem.isNotEmpty,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: FilterChip(
                            label: Text(e),
                            selected: selectedItem.contains(e),
                            onSelected: (bool value) {
                              setState(() {
                                if (selectedItem.contains(e)) {
                                  selectedItem.remove(e);
                                } else {
                                  selectedItem.add(e);
                                }
                                sortData();
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ).paddingOnly(left: 10),
              ),
            ),
            sortedData.isEmpty
                ? const Center(child: Text('No offers available'))
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: sortedData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Get.bottomSheet(
                          //   NewOrderPopUp(data: sortedData[index]),
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
                                          postController.getOperatorIcon(
                                              sortedData[index]
                                                  .offerModelSingleOperator),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                    color: Colors.transparent),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const VerticalDivider(
                                          color: Colors.transparent),
                                      Text(
                                        '${postController.numberToBangla(sortedData[index].gb)} জিবি ${postController.numberToBangla(sortedData[index].minute)} মিনিট',
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
                                                  '${postController.numberToBangla(sortedData[index].discountPrice)} ',
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
                                            '৳${postController.numberToBangla(sortedData[index].mainPrice)}',
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
                                            '${postController.numberToBangla(sortedData[index].duration)} দিন',
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
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          '${sortedData[index].offerLocation} ',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black38,
                                          ),
                                        ).paddingOnly(bottom: 5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).paddingOnly(top: 15);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
