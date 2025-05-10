import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

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
  //يعرض إشعار عادي بدون أزرار أو جدولة.
  static Future<void> showBasicNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
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
      'basic Title',
      'This is a test Basic notification.',
      notificationDetails,
    );
  }

  // repeated notification
  // إشعار متكرر كل دقيقة
  // يجدول إشعار يظهر كل دقيقة.
  // يستخدم matchDateTimeComponents: DateTimeComponents.time لتكرار الوقت.
  static Future<void> showRepeatedNotification() async {
    final now = tz.TZDateTime.now(tz.local);
    final next = now
        .add(const Duration(minutes: 1))
        .subtract(Duration(seconds: now.second));

    const androidDetails = AndroidNotificationDetails(
      'repeating_channel',
      'Repeating',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Repeating Title',
      'This repeats every minute',
      next,
      details,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // schedule notification
  // إشعار مجدول بعد وقت محدد
  // يعرض إشعار بعد 10 ثوانٍ من وقت الآن.
  //
  // يستخدم zonedSchedule() مع دعم لتحديد التوقيت بدقة.
  //
  // scheduleMode يسمح للتنفيذ حتى لو الهاتف في وضع "Doze"
  static Future<void> showScheduleNotification() async {
    final scheduledTime =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'schedule_channel_id', // يجب أن يكون ID ثابت ومميز
      'Schedule Notifications',
      channelDescription: 'This channel is for Schedule notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'Scheduled Title!',
        'This is a test Schedule notification.',
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        scheduledTime,
        notificationDetails);
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
