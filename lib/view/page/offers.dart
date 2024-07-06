import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/model/receive.dart';
import 'package:netplus/view/ui/widget/cart/recent_sell_cart.dart';
import 'package:netplus/view/ui/widget/cart/offers_area_cart.dart';
import '../ui/widget/note.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final NavbarController navbarController = Get.find();
  PostController postController = Get.find();

  List<OfferModelSingle> separateOffersByLocation(List<OfferModel> offers) {
    final List<OfferModelSingle> newOffers = [];

    for (var offer in offers) {
      for (var location in offer.offerLocation) {
        final newOffer = OfferModelSingle(
          offerId: offer.offerId,
          sellerId: offer.sellerId,
          offerModelSingleOperator: offer.offerModelOperator,
          gb: offer.gb,
          minute: offer.minute,
          mainPrice: offer.mainPrice,
          discountPrice: offer.discountPrice,
          duration: offer.duration,
          offerLocation: location,
          pack: offer.pack,
          click: offer.click,
          status: offer.status,
          time: offer.time,
        );
        newOffers.add(newOffer);
      }
    }

    // for (var offer in newOffers) {
    //   print(offer.offerModelSingleOperator);
    // }
    return newOffers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => DefaultTabController(
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            physics: const BouncingScrollPhysics(),
            controller: navbarController.scrollControllerOffer,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                toolbarHeight: 50,
                automaticallyImplyLeading: false,
                floating: true,
                snap: false,
                pinned: true,
                scrolledUnderElevation: 1,
                surfaceTintColor: Colors.white70,
                excludeHeaderSemantics: true,
                title: const Note(
                  text:
                      '👀সিমে কোন লোন নেওয়া থাকলে অফার যাবে না লোনের টাকা কেটে যাবে!',
                ).paddingOnly(top: 20, bottom: 16),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(child: Text('এলাকা ভিত্তিক')),
                      // Tab(child: Text('ফেমিলি')),
                      // Tab(child: Text('গিফট')),
                      Tab(child: Text('সাম্প্রতিক বিক্রি')),
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
                          OfferAreaCart(
                            controller: innerScrollController,
                            data: separateOffersByLocation(
                              postController.offerList.toList(),
                            ),
                          ),
                          // OfferCart(controller: innerScrollController),
                          // OfferCart(controller: innerScrollController),
                          RecentSell(controller: innerScrollController),
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
