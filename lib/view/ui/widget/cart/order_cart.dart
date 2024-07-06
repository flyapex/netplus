import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/model/receive.dart';
import '../../../../controller/postcontroller.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderCart extends StatelessWidget {
  final OrderRec data;
  const OrderCart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();

    getStatus(r) {
      if (r == 1) {
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

    return ExpandableNotifier(
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
                              child: SvgPicture.asset(
                                postController.getOperatorIcon(
                                  data.orderRecOperator,
                                ),
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
                              '${postController.numberToBangla(data.gb)} জিবি ${postController.numberToBangla(data.minute)} মিনিট',
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
                                        '${postController.numberToBangla(data.mainPrice)} ',
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
                                  '৳${postController.numberToBangla(data.discountPrice)}',
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
                                  '${postController.numberToBangla(data.duration)} দিন',
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
                            getStatus(data.status),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  data.offerLocation.map((e) => e).join(', '),
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
                                    postController
                                        .getOperatorIcon(data.orderRecOperator),
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
                                  '${postController.numberToBangla(data.gb)} জিবি ${postController.numberToBangla(data.minute)} মিনিট',
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
                                            '${postController.numberToBangla(data.mainPrice)} ',
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
                                      '৳${postController.numberToBangla(data.discountPrice)}',
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
                                      '${postController.numberToBangla(data.duration)} দিন',
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
                                getStatus(data.status),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      data.offerLocation
                                          .map((e) => e)
                                          .join(', '),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text.rich(
                          //   TextSpan(
                          //     children: [
                          //       const TextSpan(
                          //         text: '0134567890',
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //       TextSpan(
                          //         text: '  |   Status: ${getStatusTxt()}',
                          //         style: const TextStyle(color: Colors.green),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const Text(
                            '✅ 0134567890',
                            // style: TextStyle(
                            //   fontSize: 12,
                            //   color: Colors.black.withOpacity(0.7),
                            //   decorationColor: Colors.black54,
                            // ),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // '8:15 10/10/2022',
                            '${timeago.format(data.time, locale: 'en_short')} Ago',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 20, right: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).paddingOnly(top: 16);
  }
}
