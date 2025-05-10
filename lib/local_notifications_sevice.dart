import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
  }

  // basic notification
  static void showBasicNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'basic_channel_id', // يجب أن يكون ID ثابت ومميز
      'Basic Notifications',
      channelDescription: 'This channel is for basic notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello!',
      'This is a test notification.',
      notificationDetails,
    );
  }
}
