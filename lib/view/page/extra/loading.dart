import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LodingPage extends StatelessWidget {
  const LodingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Center(
                    child: LottieBuilder.asset('assets/lottie/loding.json')),
              ),
            ],
          ),
        ),
        const Text(
          'Made with ❤️ in Bangladesh',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'gettin your data',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black12,
          ),
        ),
        const SizedBox(height: 100),
      ],
    ));
  }
}
