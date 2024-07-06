import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        shadowColor: Colors.white.withOpacity(0.2),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.75),
        ),
        titleSpacing: 0,
        title: const Text(
          '  Notifications',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            splashRadius: 24,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Feather.chevron_left),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Lottie.asset('assets/lottie/notifications.json'),
                const SizedBox(height: 10),
                const Text("Nothing Here 👑"),
              ],
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}
