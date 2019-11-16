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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.lightBlue,
      ),
      home: RootPage(auth: new Auth(),),
    );
  }
}