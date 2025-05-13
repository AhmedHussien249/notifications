// تجريبي عشان اعرف منه الاخطاء

// import 'package:workmanager/workmanager.dart';
//
// import 'test_local_notifications_service.dart';
//
//
// class WorkManagerService {
//   // register one off task
//   void registerMyTask() async {
//     await Workmanager().registerOneOffTask(
//       'id1',
//       'show simple notification',
//
//     );
//
//   }
//
//   // register periodic task
//   void registerMyTaskPeriodically() async {
//     await Workmanager().registerPeriodicTask(
//       'id1',
//       'show simple notification',
//       frequency: const Duration(seconds: 15), // اقل حاجة 15 دقيقة
//
//     );
//
//   }
//
//
//   Future<void> init() async {
//     Workmanager().initialize(actionTask, isInDebugMode: true);
//     registerMyTaskPeriodically();
//   }
//
//   void cancelTask(String id) {
//     Workmanager().cancelByUniqueName(id);
//   }
// }
//
// @pragma('vm:entry-point')
// void actionTask() {
//   Workmanager().executeTask((task, inputData) async {
//      LocalNotificationsService.showDailyMorningNotification();
//     return Future.value(true);
//   });
// }
