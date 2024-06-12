import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var connection = true.obs;

  var currentIndex = 1.obs;
  get selectedIndex => currentIndex.value;
  set selectedIndex(index) => currentIndex.value = index;
  ScrollController scrollControllerOffer = ScrollController();
  ScrollController scrollControllerHome = ScrollController();
  ScrollController scrollControllerOrder = ScrollController();
  PageController pagecontroller = PageController(initialPage: 1);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}

class IconModel {
  final String icon;
  final String title;

  const IconModel({required this.icon, required this.title});
}
