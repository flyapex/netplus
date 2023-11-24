import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  var connection = true.obs;

  var currentIndex = 0.obs;
  get selectedIndex => currentIndex.value;
  set selectedIndex(index) => currentIndex.value = index;
  ScrollController scrollController = ScrollController();
}

class IconModel {
  final String icon;
  final String title;

  const IconModel({required this.icon, required this.title});
}
