import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/db_controller.dart';
import 'package:netplus/controller/usercontroller.dart';
import 'package:netplus/model/send.dart';
import 'package:video_player/video_player.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  getStatus(status) {
    if (status == 1) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(200),
        ),
        child: const Center(
          child: Icon(
            FontAwesome.refresh,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
    } else {
      return Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(200),
        ),
        child: const Center(
          child: Icon(
            FontAwesome.check,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
    }
  }

  UserController userController = Get.put(UserController());
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/2.mp4")
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          SizedBox(
            width: 400,
            height: 400,
            child: VideoPlayer(_controller),
          ),
          const SizedBox(height: 10),
          const Text(
            "NetPlus",
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              const Text(
                "By continuing,you aggree to our ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (() {}),
                    child: const Text(
                      "User Agreement and  Privacy Policy.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  var user = await GoogleSignInApi.login();
                  print(user!.email);
                  int userStatus = await userController.userLogin(
                    Newuser(
                      name: user.displayName!,
                      email: user.email,
                      imageUrl: user.photoUrl ?? "",
                      fcm: "",
                    ),
                  );

                  print(userStatus);

                  // if (userStatus == 0) {
                  //   Get.offAll(() => const BannedPage());
                  // } else if (userStatus == 1) {
                  //   Get.offAll(() => const HomeView());
                  // }
                },
                child: const SocialIcons(
                  icon: 'assets/icons/google.svg',
                  iconsize: 32,
                  title: "Sign up with Google     ",
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    'Recent',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                    ),
                  ),
                ),
                slide(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  slide() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 100,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 900),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      itemCount: 15,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.09),
                      border: Border.all(
                        width: 1,
                        color: Colors.blue.withOpacity(0.09),
                      ),
                    ),
                    child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            'https://fastly.picsum.photos/id/256/200/200.jpg?hmac=MX3r8Dktr5b26lQqb5JB6sgLnCxSgt1KRm0F1eNDHCk')),
                  ),
                ),
                const VerticalDivider(color: Colors.transparent),
                const Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalDivider(color: Colors.transparent),
                      Text(
                        '২৫ জিবি ২০০ মিনিট',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '৳',
                              style: TextStyle(
                                height: 0.9,
                                fontSize: 25,
                                color: Color(0xffF0632E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '৫৩৯ ',
                              style: TextStyle(
                                height: 0.9,
                                fontSize: 30,
                                color: Color(0xffF0632E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Feather.check_circle,
                            size: 13,
                            color: Colors.black54,
                          ),
                          VerticalDivider(width: 8),
                          Text(
                            '0191665xxxx',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              decorationColor: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // const SizedBox(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 1),
                          child: getStatus(itemIndex),
                        ),
                      ),

                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            '3m ago',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SocialIcons extends StatelessWidget {
  final String icon;
  final String title;
  final double iconsize;

  const SocialIcons({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(0.3),
        color: const Color(0xff161A2D),

        borderRadius: BorderRadius.circular(100),
        // border: Border.all(
        //   color: Colors.purple,
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 35,
            width: 35,
            color: Colors.transparent,
            child: Center(
              child: SvgPicture.asset(
                icon,
                height: iconsize,
                width: iconsize,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
