import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:netplus/controller/usercontroller.dart';
import 'package:netplus/view/home_view.dart';
import 'package:netplus/view/page/extra/loading.dart';
import 'view/page/extra/banned.dart';
import 'view/page/login.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.notification?.title}");
//   print("Handling a background message: ${message.notification?.body}");
//   print("Handling a background message: ${message.data}");
// }

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationHelper.initializeNotifications();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, badge: true, sound: true);
  // // // final fcmToken = await FirebaseMessaging.instance.getToken();
  // final fcmToken = await messaging.getToken();

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');
  // await FirebaseMessaging.instance.subscribeToTopic('allUsers');
  // // LocalNotificationService.initialize();
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   if (message.notification != null) {
  //     print('Notification Title: ${message.notification?.title}');
  //     print('Notification Body: ${message.notification?.body}');
  //     NotificationHelper.showNotification(
  //       '${message.notification?.title}',
  //       '${message.notification?.body}',
  //     );
  //   }
  // });

  // print('--------------------------');
  // print(fcmToken);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
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

    UserController userController = Get.put(UserController());
    userController.getUserDetails();
    return Obx(() {
      setStatus(userStatus) {
        if (userStatus == 0) {
          return const BannedPage();
        } else if (userStatus == 1) {
          return const HomeView();
        } else {
          return const Login();
        }
      }

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNets',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        home: userController.isLoading.value
            ? const LodingPage()
            : setStatus(userController.status.value),
      );
    });
  }
}
