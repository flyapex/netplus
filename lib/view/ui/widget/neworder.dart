import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/model/receive.dart';
import 'textinput.dart';

class NewOrderPopUp extends StatefulWidget {
  final OfferModel data;
  const NewOrderPopUp({super.key, required this.data});

  @override
  State<NewOrderPopUp> createState() => _NewOrderPopUpState();
}

class _NewOrderPopUpState extends State<NewOrderPopUp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 100),
      height: Get.height - 80,
      width: Get.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.only(top: 5, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: NewOrderPopUpCart(
              data: widget.data,
            ),
          ),
        ],
      ),
    );
  }
}

class NewOrderPopUpCart extends StatelessWidget {
  final OfferModel data;
  const NewOrderPopUpCart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    NavbarController navbarController = Get.find();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'অফার কিনুন',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.09),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffEC008C).withOpacity(0.09),
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: SvgPicture.asset(
                            postController
                                .getOperatorIcon(data.offerModelOperator),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(color: Colors.transparent),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${postController.numberToBangla(data.gb)} জিবি ${postController.numberToBangla(data.minute)} মিনিট',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xffF0632E),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${postController.numberToBangla(data.mainPrice)} ',
                                style: const TextStyle(
                                  height: 0.9,
                                  fontSize: 30,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: 'টাকা',
                                style: TextStyle(
                                  height: 0.9,
                                  fontSize: 27,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '৳${postController.numberToBangla(data.discountPrice)}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextInputBoxOnly(
                  topPadding: 30,
                  title: "১১ ডিজিটের নাম্বার *",
                  textType: TextInputType.number,
                  hintText: "Only 11 Digit Number",
                  controller: postController.number,
                  widthh: 2.35 / 2,
                ),
                const SizedBox(height: 20),
                const Text(
                  'লোকেশন',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    decorationColor: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                TextInputBoxOnly(
                  topPadding: 30,
                  title: "কুপন (যদি থাকে)",
                  textType: TextInputType.text,
                  hintText: "FREE2024",
                  controller: postController.cupon,
                  widthh: 2.35 / 2,
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Get.height / 17,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        // Timer(const Duration(milliseconds: 500), () async {
                        //   Get.back();
                        // });
                        // Timer(const Duration(milliseconds: 500), () async {
                        //   await postController.newOrder(data.offerId);
                        // });
                        await postController.newOrder(data.offerId);
                        postController.refreshkey.currentState!.refresh(
                          draggingDuration: const Duration(milliseconds: 350),
                          draggingCurve: Curves.easeOutBack,
                        );
                        navbarController.selectedIndex = 2;
                        navbarController.pagecontroller.jumpToPage(2);
                      },
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/cart.svg',
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Buy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      elevation: 0.2,
                      backgroundColor: Colors.green,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
