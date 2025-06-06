// تجريبي عشان اعرف منه الاخطاء

// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
//
// import 'main.dart';
//
// class LocalNotificationsService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   // static StreamController<NotificationResponse> streamController =
//   //     StreamController();
//
//   static onTap(NotificationResponse notificationResponse) {
//
//    // log(notificationResponse.id!.toString());
//    // log(notificationResponse.payload!.toString());
//    // streamController.add(notificationResponse);
//
//
//     // hast5dm y3m el routes bdl el lft el stream el fshla d el stream d 3shan
//     // 7gat tnya api w firebase w kda
//     // h3ml bs navigatorKey f el main global w ageb beh el context
//     final id = notificationResponse.id;
//     if (id == 0) {
//       // استخدم navigatorKey للانتقال للصفحة المناسبة
//       navigatorKey.currentState?.pushNamed('basicView');
//       log(notificationResponse.id!.toString());
//     }else if (id == 2) {
//       navigatorKey.currentState?.pushNamed('scheduleView');
//       log(notificationResponse.payload!.toString());
//     }
//   }
//
//   static Future<void> init() async {
//     InitializationSettings settings = const InitializationSettings(
//         android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//         iOS: DarwinInitializationSettings());
//     flutterLocalNotificationsPlugin.initialize(settings,
//         onDidReceiveNotificationResponse: onTap,
//         onDidReceiveBackgroundNotificationResponse: onTap);
//   }
//
//   // basic notification
//   //يعرض إشعار عادي بدون أزرار أو جدولة.
//   static Future<void> showBasicNotification() async {
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'basic_channel_id', // يجب أن يكون ID ثابت ومميز
//       'Basic Notifications',
//       channelDescription: 'This channel is for basic notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound(
//           'notifications.wav'.split('.').first),
//     );
//
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'basic Title',
//       'This is a test Basic notification.',
//       notificationDetails,
//       payload: 'Basic Notification',
//     );
//   }
//
//   // repeated notification
//   // إشعار متكرر كل دقيقة
//   // يجدول إشعار يظهر كل دقيقة.
//   // يستخدم matchDateTimeComponents: DateTimeComponents.time لتكرار الوقت.
//   static Future<void> showRepeatedNotification() async {
//     tz.initializeTimeZones();
//     final now = tz.TZDateTime.now(tz.local);
//     final next = now
//         .add(const Duration(minutes: 1))
//         .subtract(Duration(seconds: now.second));
//
//     const androidDetails = AndroidNotificationDetails(
//       'repeating_channel',
//       'Repeating',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     const details = NotificationDetails(android: androidDetails);
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1,
//       'Repeating Title',
//       'This repeats every minute',
//       next,
//       details,
//       matchDateTimeComponents: DateTimeComponents.time,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }
//
//   // schedule notification
//   // إشعار مجدول بعد وقت محدد
//   // يعرض إشعار بعد 10 ثوانٍ من وقت الآن.
//   //
//   // يستخدم zonedSchedule() مع دعم لتحديد التوقيت بدقة.
//   //
//   // scheduleMode يسمح للتنفيذ حتى لو الهاتف في وضع "Doze"
//   static Future<void> showScheduleNotification() async {
//     tz.initializeTimeZones();
//     final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//
//     // 🟢 اطبع المنطقة (المكان) هنا
//     log("📍 التوقيت المحلي الحالي: $currentTimeZone");
//
//
//     tz.setLocalLocation(tz.getLocation(currentTimeZone));
//
//     final scheduledTime =
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
//     log("⏰ سيتم إرسال الإشعار في: $scheduledTime");
//
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'schedule_channel_id',
//       'Schedule Notifications',
//       channelDescription: 'This channel is for Schedule notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       2,
//       'Scheduled Title!',
//       'This is a test Schedule notification.',
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       scheduledTime,
//       notificationDetails,
//       payload: 'Scheduled Notification',
//     );
//   }
//
//   static Future<void> showDailyMorningNotification() async {
//     // لا تستخدم await مع tz.initializeTimeZones()
//     tz.initializeTimeZones();  // فقط استدعها مباشرة
//
//     final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(currentTimeZone));
//
//     // تحديد الوقت اليوم الساعة 9 صباحًا
//     final now = tz.TZDateTime.now(tz.local);
//     var scheduledDate =
//     tz.TZDateTime(tz.local, now.year, now.month, now.day, 23, 38);
//
//     // إذا كان الوقت الحالي قد مرّ الساعة 9، اضبط الإشعار ليوم غدٍ
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     log("⏰ سيتم إرسال الإشعار يوميًا الساعة 9 صباحًا في: $scheduledDate");
//
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//       'daily_morning_channel_id',
//       'Daily Morning Notifications',
//       channelDescription: 'This channel is for daily morning notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       3, // ID فريد
//       'صباح الخير!',
//       'ابدأ يومك بنشاط 💪',
//       scheduledDate,
//       notificationDetails,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents: DateTimeComponents.time, // التكرار يوميًا
//     );
//   }
//
//   static Future<void> cancelNotification(int id) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
//
//   static Future<void> cancelAllNotification(int id) async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
