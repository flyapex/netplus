import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarController navbarController = Get.find();
    List<String> items = List.generate(100, (index) => 'Item $index');
    return Scaffold(
      body: ListView.builder(
        controller: navbarController.scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
