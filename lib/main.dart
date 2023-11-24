import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:netplus/view/home.dart';
import 'package:netplus/view/offers.dart';
import 'package:netplus/view/orders.dart';

import 'controller/navcontroller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final NavbarController navbarController = Get.put(NavbarController());

  var currentIndex = 0;
  final List<Widget> pageList = [
    const Home(),
    const Offers(),
    const Orders(),
  ];
  List<IconModel> icons = [
    const IconModel(icon: 'assets/icons/offers.svg', title: 'Offers'),
    const IconModel(icon: 'assets/icons/homeView.svg', title: 'Home'),
    const IconModel(icon: 'assets/icons/history.svg', title: 'Orders'),
  ];

  final GlobalKey<NestedScrollViewState> globalKey = GlobalKey();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )
    ..addListener(() {
      setState(() {});
    })
    ..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: const Offset(0, 3.4),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  @override
  void initState() {
    navbarController.scrollController.addListener(
      () {
        if (navbarController.scrollController.position.pixels > 0) {}
        if (navbarController.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) _controller.reverse();
        }
        if (navbarController.scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          _controller.forward();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('Animated Bottom Bar'),
        ),
        body: Center(child: pageList.elementAt(navbarController.selectedIndex)),
        bottomNavigationBar: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            color: Colors.transparent,
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      navbarController.selectedIndex = 0;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: navbarController.selectedIndex == 0
                                ? const Color(0xfff57224).withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 17,
                                width: 17,
                                child: SvgPicture.asset(
                                  'assets/icons/offers.svg',
                                  colorFilter: ColorFilter.mode(
                                    navbarController.selectedIndex == 0
                                        ? const Color(0xfff57224)
                                        : Colors.blueGrey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Offers",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: navbarController.selectedIndex == 0
                                      ? const Color(0xfff57224)
                                      : Colors.blueGrey,
                                  fontWeight:
                                      navbarController.selectedIndex == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navbarController.selectedIndex = 1;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: navbarController.selectedIndex == 1
                                ? const Color(0xfff57224).withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 17,
                                width: 17,
                                child: SvgPicture.asset(
                                  'assets/icons/homeView.svg',
                                  colorFilter: ColorFilter.mode(
                                    navbarController.selectedIndex == 1
                                        ? const Color(0xfff57224)
                                        : Colors.blueGrey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: navbarController.selectedIndex == 1
                                      ? const Color(0xfff57224)
                                      : Colors.blueGrey,
                                  fontWeight:
                                      navbarController.selectedIndex == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navbarController.selectedIndex = 2;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: navbarController.selectedIndex == 2
                                ? const Color(0xfff57224).withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 17,
                                width: 17,
                                child: SvgPicture.asset(
                                  'assets/icons/history.svg',
                                  colorFilter: ColorFilter.mode(
                                    navbarController.selectedIndex == 2
                                        ? const Color(0xfff57224)
                                        : Colors.blueGrey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Order',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: navbarController.selectedIndex == 2
                                      ? const Color(0xfff57224)
                                      : Colors.blueGrey,
                                  fontWeight:
                                      navbarController.selectedIndex == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
