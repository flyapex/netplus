import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';
import 'package:netplus/controller/usercontroller.dart';
import 'package:netplus/view/widget/notification.dart';

class ReusableAppBar {
  static getAppBar(context) {
    NavbarController navbarController = Get.find();
    UserController userController = Get.find();
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      elevation: 1,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      centerTitle: true,
      title: SizedBox(
        height: 26,
        width: 26,
        child: Image.asset('assets/logo/logo.png'),
      ),
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  navbarController.openDrawer();
                },
                icon: CircleAvatar(
                  // backgroundImage: NetworkImage(),
                  backgroundImage: NetworkImage(userController.image.value),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  const Text('Galib'),
                  // Text('  ${userController.name.value}'),
                  Center(
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xff33484D),
                        // color: const Color(0xff213040),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () {
                          // navbarController.selectedIndex = 3;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4, right: 10),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xff46B962),
                                  // color: const Color(0xff46B962),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(
                                  FontAwesome.plus,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                '100 ৳',
                                // '${userController.deposit.value} \$',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffe8e8ea),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(
              const NotificationPage(),
              // transition: Transition.cupertinoDialog,
              // duration: const Duration(milliseconds: 200),
              transition: Transition.circularReveal,
              duration: const Duration(milliseconds: 600),
            );
          },
          icon: const Icon(
            Feather.bell,
            size: 22,
          ),
          splashRadius: 25,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Feather.message_square,
            size: 22,
          ),
          splashRadius: 25,
        ),
      ],
    );
  }
}
