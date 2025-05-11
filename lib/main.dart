import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notifications/basic_notification_view.dart';
import 'package:notifications/schedule_notification_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'local_notifications_sevice.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await LocalNotificationsService.init();
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Local Notification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      routes: {
        'basicView': (context) => const BasicNotificationView(),
        'scheduleView': (context) => const ScheduleNotificationView(),
        'homeView': (context) => const HomeView(),
      },
     initialRoute: 'homeView',
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   listenToStreamNotification();
  // }

  // void listenToStreamNotification() {
  //   LocalNotificationsService.streamController.stream.listen(
  //     (notificationResponse) {
  //       log(notificationResponse.id!.toString());
  //       log(notificationResponse.payload!.toString());
  //       if (notificationResponse.id == 0) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const BasicNotificationView(),
  //           ),
  //         );
  //       } else if (notificationResponse.id == 2) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const ScheduleNotificationView(),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  // kol d mlosh lzma ela f 7alat mo3yna zy el api w firebase lakn ana hst5dm
  // el routes 3shan ageb el context w ht7k feha b navigatorKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification'),
        leading: const Icon(Icons.notifications),
        titleSpacing: 0.0,
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            onTap: () {
              LocalNotificationsService.showBasicNotification();
            },
            title: const Text('Basic Notification'),
            leading: const Icon(Icons.notifications),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationsService.cancelNotification(0);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              LocalNotificationsService.showRepeatedNotification();
            },
            title: const Text('RepeatedNotification'),
            leading: const Icon(Icons.notifications),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationsService.cancelNotification(1);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              LocalNotificationsService.showScheduleNotification();
            },
            title: const Text('ScheduleNotification'),
            leading: const Icon(Icons.notifications),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationsService.cancelNotification(2);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              LocalNotificationsService.showDailyMorningNotification();
            },
            title: const Text('daily morning Notification'),
            leading: const Icon(Icons.notifications),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationsService.cancelNotification(2);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
