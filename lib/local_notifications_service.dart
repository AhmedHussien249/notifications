import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'main.dart';

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // static StreamController<NotificationResponse> streamController =
  //     StreamController();

  static onTap(NotificationResponse notificationResponse) {
    // log(notificationResponse.id!.toString());
    // log(notificationResponse.payload!.toString());
    // streamController.add(notificationResponse);

    // hast5dm y3m el routes bdl el lft el stream el fshla d el stream d 3shan
    // 7gat tnya api w firebase w kda
    // h3ml bs navigatorKey f el main global w ageb beh el context
    final id = notificationResponse.id;
    if (id == 0) {
      // استخدم navigatorKey للانتقال للصفحة المناسبة
      navigatorKey.currentState?.pushNamed('basicView');
      log(notificationResponse.id!.toString());
    } else if (id == 2) {
      navigatorKey.currentState?.pushNamed('scheduleView');
      log(notificationResponse.payload!.toString());
    }
  }

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
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'basic_channel_id', // يجب أن يكون ID ثابت ومميز
      'Basic Notifications',
      channelDescription: 'This channel is for basic notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'notifications.wav'.split('.').first),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'basic Title',
      'This is a test Basic notification.',
      notificationDetails,
      payload: 'Basic Notification',
    );
  }

  // repeated notification
  // إشعار متكرر كل دقيقة
  // يجدول إشعار يظهر كل دقيقة.
  // يستخدم matchDateTimeComponents: DateTimeComponents.time لتكرار الوقت.
  static Future<void> showRepeatedNotification() async {
    tz.initializeTimeZones();

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
      1,
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
    tz.initializeTimeZones();

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    // 🟢 اطبع المنطقة (المكان) هنا
    log("📍 التوقيت المحلي الحالي: $currentTimeZone");

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    final scheduledTime =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    log("⏰ سيتم إرسال الإشعار في: $scheduledTime");

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'schedule_channel_id',
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
      notificationDetails,
      payload: 'Scheduled Notification',
    );
  }

  static Future<void> showDailyMorningNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'morning_channel_id', // يجب أن يكون ID ثابت ومميز
      'Basic Notifications',
      channelDescription: 'This channel is for basic notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'notifications.wav'.split('.').first),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    tz.initializeTimeZones();

    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // تحديد الوقت اليوم الساعة 9 صباحًا
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);

    //لو عدّى الوقت الحالي الساعة 9، يبقى ابعته بكرة
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    log("⏰ سيتم إرسال الإشعار يوميًا الساعة 9 صباحًا في: $scheduledDate");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3, // ID فريد
      'good morning!',
      'start your day with a cup of coffee',
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // التكرار يوميًا
    );
  }

  static Future<void> showDailyNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'daily_channel_id', // يجب أن يكون ID ثابت ومميز
      'daily Notifications',
      channelDescription: 'This channel is for basic notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'notifications.wav'.split('.').first),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    tz.initializeTimeZones();

     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    log(tz.local.toString());
    var currentTime = tz.TZDateTime.now(tz.local);
    log(currentTime.toString());
    log("currentTime.year:${currentTime.year}");
    log("currentTime.month:${currentTime.month}");
    log("currentTime.day:${currentTime.day}");
    log("currentTime.hour:${currentTime.hour}");
    log("currentTime.minute:${currentTime.minute}");
    log("currentTime.second:${currentTime.second}");
    var scheduledDate = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      9,

    );
    log("scheduledTime.year:${scheduledDate.year}");
    log("scheduledTime.month:${scheduledDate.month}");
    log("scheduledTime.day:${scheduledDate.day}");
    log("scheduledTime.hour:${scheduledDate.hour}");
    log("scheduledTime.minute:${scheduledDate.minute}");
    log("scheduledTime.second:${scheduledDate.second}");
    if (scheduledDate.isBefore(currentTime)) {
 scheduledDate = scheduledDate.add(const Duration(days: 1));
 }
    log("After Added scheduledTime.year:${scheduledDate.year}");
    log("After Added scheduledTime.month:${scheduledDate.month}");
    log("After Added scheduledTime.day:${scheduledDate.day}");
    log("After Added scheduledTime.hour:${scheduledDate.hour}");
    log("After Added scheduledTime.minute:${scheduledDate.minute}");
    log("After Added scheduledTime.second:${scheduledDate.second}");
    log('Added Duration to scheduled time');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      5,
      'Daily Notification',
      'This is a test daily notification',
      scheduledDate,
      payload: 'zonedSchedule',
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
// tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
//
// if (scheduledDate.isBefore(currentTime)) {
// scheduledDate = scheduledDate.add(const Duration(minutes: 11));
// }