import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void pushFCMtoken() async {
    messaging.getInitialMessage(); // optional
    String? token = await messaging.getToken();
    // print(token); // Prints the Token in the console.
  }

  void initMessaging() async {
    FlutterLocalNotificationsPlugin fltNotification;

    // Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Initialization Settings for iOS
    const initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initializationSettings);
    var androidDetails =
        const AndroidNotificationDetails('channel_name', 'channel_id');
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          // Do Something with the notification title and body
          fltNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            generalNotificationDetails,
          );
        }
      });
    } catch (e) {
      // print('Error Running Notification in Foreground: $e');
      return;
    } // Notification Config.
  }

  @override
  void initState() {
    super.initState();
    pushFCMtoken();
    initMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tee Chat'), actions: [
        DropdownButton(
          underline: Container(),
          items: [
            DropdownMenuItem(
              value: 'logout',
              child: Row(
                children: const [
                  Icon(Icons.exit_to_app, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
      ]),
      body: SizedBox(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
