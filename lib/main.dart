import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/answer_page.dart';
import 'package:katy_mental_health/Pages/breathing_page.dart';
import 'package:katy_mental_health/Pages/calendar_page.dart';
import 'package:katy_mental_health/Pages/more_page.dart';
import 'package:katy_mental_health/Pages/root_page.dart';
import 'package:katy_mental_health/Pages/community_page.dart';
import 'package:katy_mental_health/Pages/stats_page.dart';
import 'package:katy_mental_health/Utils/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: RootPage(auth: new Auth(),),
    );
  }
}