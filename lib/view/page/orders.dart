import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/model/receive.dart';
import 'package:netplus/view/ui/widget/cart/order_cart.dart';
import '../../controller/navcontroller.dart';
import '../ui/widget/note.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({
    super.key,
  });

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  NavbarController navbarController = Get.find();
  PostController postController = Get.find();

  late List<OrderRec> filteredData = [];

  final Map<String, int> durationMap = {
    "1 দিন": 1,
    "3 দিন": 3,
    "7 দিন": 7,
    "15 দিন": 15,
    "30 দিন": 30,
  };

  final items = [
    "1 দিন",
    "3 দিন",
    "7 দিন",
    "15 দিন",
    "30 দিন",
  ];

  List<String> selectedItem = [];

  void sortData() {
    print('Selected Items: $selectedItem');

    if (selectedItem.isNotEmpty) {
      List<int> selectedDurations = selectedItem.map((item) {
        return durationMap[item]!;
      }).toList();

      DateTime now = DateTime.now();
      filteredData = postController.historyList.where((order) {
        return selectedDurations.any((duration) {
          return now.difference(order.time).inDays <= duration;
        });
      }).toList();
    } else {
      filteredData = List.from(postController.historyList);
    }

    print('Filtered Data Length: ${filteredData.length}');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          filteredData = List.from(postController.historyList);
          return postController.historyLoding.value
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
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
                      postController.historyList.clear();
                      postController.historyList.refresh();
                      postController.getHistory();
                      postController.historyList.sentToStream;
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: items
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 10),
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
                            if (filteredData.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('No data available!'),
                                ),
                              )
                            else
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: filteredData.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < filteredData.length) {
                                    return OrderCart(data: filteredData[index]);
                                  } else {
                                    return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text('nothing more to load!'),
                                      ),
                                    );
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
