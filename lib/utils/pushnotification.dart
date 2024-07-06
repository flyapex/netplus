// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PushNotifications {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future init() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     final token = await _firebaseMessaging.getToken();
//     print("device token: $token");
//   }

// // initalize local notifications
//   static Future localNotiInit() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) {},
//     );
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onNotificationTap,
//         onDidReceiveBackgroundNotificationResponse: onNotificationTap);
//   }

//   // on tap local notification in foreground
//   static void onNotificationTap(NotificationResponse notificationResponse) {}

//   // show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin.show(
//         0, title, body, notificationDetails);
//   }
// }

// ignore_for_file: file_names

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   // Instance of Flutternotification plugin
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static void initialize() {
//     // Initialization  setting for android
//     const InitializationSettings initializationSettingsAndroid =
//         InitializationSettings(
//       android: AndroidInitializationSettings("@drawable/ic_launcher"),
//     );
//     _notificationsPlugin.initialize(
//       initializationSettingsAndroid,
//       onDidReceiveNotificationResponse: (details) {
//         if (details.input != null) {}
//       },
//     );
//   }

//   static Future<void> display(RemoteMessage message) async {
//     // To display the notification in device
//     try {
//       print(message.notification!.android!.sound);
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           message.notification!.android!.sound ?? "Channel Id",
//           message.notification!.android!.sound ?? "Main Channel",
//           playSound: true,
//           priority: Priority.high,
//         ),
//       );
//       await _notificationsPlugin.show(id, message.notification?.title,
//           message.notification?.body, notificationDetails,
//           payload: message.data['route']);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
