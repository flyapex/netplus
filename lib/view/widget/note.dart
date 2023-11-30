import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Note extends StatelessWidget {
  final String text;
  const Note({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserController userController = Get.find();
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
          child: Marquee(
            text: text,

            scrollAxis: Axis.horizontal,
            // crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 100.0,
            velocity: 100.0,
            pauseAfterRound: const Duration(seconds: 1),
            // startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      ),
    );
  }
}
