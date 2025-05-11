import 'package:flutter/material.dart';

class ScheduleNotificationView extends StatelessWidget {
  const ScheduleNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Notification'),
        leading: const Icon(Icons.notifications),
        titleSpacing: 0.0,
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}
