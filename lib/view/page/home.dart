import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/view/ui/widget/cart/offer_cart.dart';
import 'package:netplus/view/ui/home/time_counter.dart';
import 'package:netplus/view/ui/home/imageslider.dart';
import 'package:netplus/view/ui/widget/note.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final NavbarController navbarController = Get.find();
    PostController postController = Get.put(PostController());
    return Scaffold(
      body: Obx(
        () => DefaultTabController(
          length: 4,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            physics: const BouncingScrollPhysics(),
            controller: navbarController.scrollControllerHome,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                toolbarHeight: 320,
                // backgroundColor: Colors.red,
                // key: GlobalKey(),
                automaticallyImplyLeading: false,
                floating: true,
                snap: false,
                pinned: true,
                scrolledUnderElevation: 1,
                surfaceTintColor: Colors.white70,
                excludeHeaderSemantics: true,
                // forceElevated: innerBoxIsScrolled,
                // flexibleSpace:
                //     const FlexibleSpaceBar(collapseMode: CollapseMode.pin),
                // titleSpacing: 0,
                title: Column(
                  children: [
                    const Note(
                      text:
                          '👀সিমে কোন লোন নেওয়া থাকলে অফার যাবে না লোনের টাকা কেটে যাবে!',
                    ).paddingOnly(top: 20, bottom: 16),
                    postController.offerListLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ImageSlide(
                            hight: 160,
                            data: postController.offerList
                                .where((item) => item.offerModelOperator == 1)
                                .toList(),
                          ).paddingOnly(bottom: 16),
                    const Counter().paddingOnly(bottom: 16),
                  ],
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(child: Text('GP')),
                      Tab(child: Text('Robi')),
                      Tab(child: Text('Airtel')),
                      Tab(child: Text('BL')),
                    ],
                  ),
                ),
              ),
            ],
            body: postController.offerListLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Builder(
                    builder: (BuildContext context) {
                      final innerScrollController =
                          PrimaryScrollController.of(context);
                      return TabBarView(
                        children: [
                          OfferCart(
                            controller: innerScrollController,
                            data: postController.offerList
                                .where((item) => item.offerModelOperator == 1)
                                .toList(),
                          ),
                          OfferCart(
                            controller: innerScrollController,
                            data: postController.offerList
                                .where((item) => item.offerModelOperator == 2)
                                .toList(),
                          ),
                          OfferCart(
                            controller: innerScrollController,
                            data: postController.offerList
                                .where((item) => item.offerModelOperator == 3)
                                .toList(),
                          ),
                          OfferCart(
                            controller: innerScrollController,
                            data: postController.offerList
                                .where((item) => item.offerModelOperator == 4)
                                .toList(),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
