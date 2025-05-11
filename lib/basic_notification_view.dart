import 'package:flutter/material.dart';

class BasicNotificationView extends StatelessWidget {
  const BasicNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Notification'),
        leading: const Icon(Icons.notifications),
        titleSpacing: 0.0,
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}
