import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:Speculus/Pages/answer_page.dart';
import 'package:Speculus/Pages/breathing_page.dart';
import 'package:Speculus/Pages/calendar_page.dart';
import 'package:Speculus/Pages/more_page.dart';
import 'package:Speculus/Pages/root_page.dart';
import 'package:Speculus/Pages/community_page.dart';
import 'package:Speculus/Pages/stats_page.dart';
import 'package:Speculus/Utils/auth.dart';
import 'package:quiver/time.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:async/async.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
var initializationSettingsAndroid =
new AndroidInitializationSettings('app_icon');
var initializationSettingsIOS = IOSInitializationSettings(
  //nothing for now
  );

var initializationSettings = InitializationSettings(
    initializationSettingsAndroid, initializationSettingsIOS);
//flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);

Future onSelectNotification(String dailyMessage) async {
  if (dailyMessage != null) {
    debugPrint('Daily message: ' + dailyMessage);
  }
}

var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id', 'your channel name', 'your channel description',
    importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
var iOSPlatformChannelSpecifics = IOSNotificationDetails();
var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.white,
        accentColor: Colors.lightBlue,
      ),
      home: RootPage(auth: new Auth(),),
    );
  }
}

var time = new Time(10, 0, 0);

