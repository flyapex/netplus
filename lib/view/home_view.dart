import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:netplus/utils/connectivity_controller.dart';
import 'package:netplus/controller/postcontroller.dart';
import 'package:netplus/controller/usercontroller.dart';
import 'package:netplus/view/page/home.dart';
import 'package:netplus/view/page/offers.dart';
import 'package:netplus/view/page/orders.dart';
import 'package:netplus/view/ui/widget/appbar.dart';
import 'package:netplus/view/ui/widget/drawer.dart';
import '../controller/navcontroller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final NavbarController navbarController = Get.put(NavbarController());
  final PostController postController = Get.put(PostController());
  UserController userController = Get.put(UserController());
  ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  getMyoffers() async {
    print('api called');
    await postController.myOfferApi();
  }

  getHistory() async {
    await postController.getHistory();
  }

  var currentIndex = 1;
  final List<Widget> pageList = [
    const Offers(),
    const Home(),
    const Orders(),
  ];

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
  // getNofi() async {
  //   print('--------------------------------------------------');
  //   await FirebaseMessagingService.initializeFirebaseMessaging();
  // }

  @override
  void initState() {
    // getNofi();
    navbarController.scrollControllerHome.addListener(
      () {
        if (navbarController.scrollControllerHome.position.pixels > 0) {}
        if (navbarController
                .scrollControllerHome.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) _controller.reverse();
        }
        if (navbarController
                .scrollControllerHome.position.userScrollDirection ==
            ScrollDirection.forward) {
          _controller.forward();
        }
      },
    );
    navbarController.scrollControllerOffer.addListener(
      () {
        if (navbarController.scrollControllerOffer.position.pixels > 0) {}
        if (navbarController
                .scrollControllerOffer.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) _controller.reverse();
        }
        if (navbarController
                .scrollControllerOffer.position.userScrollDirection ==
            ScrollDirection.forward) {
          _controller.forward();
        }
      },
    );
    navbarController.scrollControllerOrder.addListener(
      () {
        if (navbarController.scrollControllerOrder.position.pixels > 0) {}
        if (navbarController
                .scrollControllerOrder.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_offsetAnimation.isCompleted) _controller.reverse();
        }
        if (navbarController
                .scrollControllerOrder.position.userScrollDirection ==
            ScrollDirection.forward) {
          _controller.forward();
        }
      },
    );

    super.initState();
    getMyoffers();
    getHistory();
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
        key: navbarController.scaffoldKey,
        extendBody: true,
        appBar: ReusableAppBar.getAppBar(context),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xffF0632E),
          ),
          child: const CustomeDrawer(),
        ),
        // body:
        //     connectivityController.connectionType == MConnectivityResult.wifi ||
        //             connectivityController.connectionType ==
        //                 MConnectivityResult.mobile
        //         ? Center(
        //             child: PageView(
        //               allowImplicitScrolling: true,
        //               scrollDirection: Axis.horizontal,
        //               controller: navbarController.pagecontroller,
        //               onPageChanged: (currentPage) {
        //                 navbarController.currentIndex.value = currentPage;
        //               },
        //               children: pageList,
        //             ),
        //           )
        //         : const NoInternet(),
        body: Center(
          child: PageView(
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            controller: navbarController.pagecontroller,
            onPageChanged: (currentPage) {
              navbarController.currentIndex.value = currentPage;
            },
            children: pageList,
          ),
        ),
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
                      navbarController.pagecontroller.jumpToPage(0);
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
                      navbarController.pagecontroller.jumpToPage(1);
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
                                  'assets/icons/home.svg',
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
                      navbarController.pagecontroller.jumpToPage(2);
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
