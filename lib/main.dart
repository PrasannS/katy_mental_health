import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/answer_page.dart';
import 'package:katy_mental_health/Pages/calendar_page.dart';

import 'Pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: CalendarPage(),
    );
  }
}
