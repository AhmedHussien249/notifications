import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'local_notifications_sevice.dart';

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
      title: 'Local Notification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        ],
      ),
    );
  }
}
