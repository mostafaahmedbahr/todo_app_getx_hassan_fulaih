import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
 import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app_getx_hassan_fulaih/models/task.dart';

import '../ui/pages/notification_screen.dart';
class NotifyHelper {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  initializeNotification()async
  {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('appicon');
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const InitializationSettings initializationSettings =   InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload)async{
          selectNotification(payload!);
        });
  }

  requestIosPermission()
  {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(
      sound: true,
      alert: true,
      badge: true,
    );
  }

  Future selectNotification(String? payload) async {
    // if (payload != null) {
      debugPrint('notification payload: $payload');
    // }
    await Get.to(()=>NotificationScreen(payLoad: payload!,));
  }


  displayNotifications({
    required String title,
    required String body,
}) async {
        AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,);
        IOSNotificationDetails iosPlatformChannelSpecifics = const IOSNotificationDetails();
            NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, title, body, platformChannelSpecifics,
            payload: 'item x');
  }


scheduledNotification()async
{
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name','your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime);
}





  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body!));
  }
}
