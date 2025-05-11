import 'package:workmanager/workmanager.dart';

import 'local_notifications_sevice.dart';

class WorkManagerService {
  // register one off task
  void registerMyTask() async {
    await Workmanager().registerOneOffTask(
      'id1',
      'show simple notification',

    );

  }

  // register periodic task
  void registerMyTaskPeriodically() async {
    await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(minutes: 15), // اقل حاجة 15 دقيقة

    );

  }


  Future<void> init() async {
    Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm:entry-point')
void actionTask() {
  Workmanager().executeTask((task, inputData) async {
     LocalNotificationsService.showBasicNotification();
    return Future.value(true);
  });
}
