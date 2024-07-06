import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netplus/controller/navcontroller.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final NavbarController navbarController = Get.find();

  late Timer _timer;
  late Duration _countdownDuration;
  String _translateNumberToBangla(int number) {
    Map<int, String> banglaNumbers = {
      0: '০',
      1: '১',
      2: '২',
      3: '৩',
      4: '৪',
      5: '৫',
      6: '৬',
      7: '৭',
      8: '৮',
      9: '৯',
    };

    String banglaNumber = '';
    String numString = number.toString();
    for (int i = 0; i < numString.length; i++) {
      banglaNumber += banglaNumbers[int.parse(numString[i])]!;
    }
    return banglaNumber;
  }

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    DateTime now = DateTime.now();
    DateTime targetTime = DateTime(now.year, now.month, now.day, 9, 0, 0);

    if (now.isAfter(targetTime)) {
      targetTime = targetTime.add(const Duration(days: 1));
    }

    _countdownDuration = targetTime.difference(now);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownDuration.inSeconds <= 0) {
          _timer.cancel();
          print('Countdown reached 0');
        } else {
          _countdownDuration = _countdownDuration - const Duration(seconds: 1);
        }
      });
      // if (_countdownDuration.inSeconds <= 0) {
      //   _timer.cancel();
      //   print('Countdown reached 0');
      // } else {
      //   _countdownDuration = _countdownDuration - const Duration(seconds: 1);
      // }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int hours = _countdownDuration.inHours % 24;
    int minutes = (_countdownDuration.inMinutes % 60);
    int seconds = (_countdownDuration.inSeconds % 60);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'নতুন অফার শুরু হবে',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffF0632E),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                timeDesign(hours, 'h'),
                timeDesign(minutes, 'm'),
                timeDesign(seconds, 's'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container timeDesign(int hours, String end) {
    return Container(
      height: 35,
      width: Get.width / 9,
      decoration: BoxDecoration(
        color: const Color(0xff3D444E),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '${_translateNumberToBangla(hours)} $end',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
