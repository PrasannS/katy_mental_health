import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katy_mental_health/Models/entry.dart';
import 'package:katy_mental_health/Persistence/database.dart';
import 'graph_types.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<int> sleep = new List<int>(),
      mood = new List<int>(),
      water = new List<int>(),
      questionId = new List<int>(),
      activity = new List<int>();
  List<String> answer = new List<String>(), note = new List<String>();

  void updateGraphs(List<Entry> entryList) {
    if(mounted) {
      setState(() {
        sleep = new List<int>();
        mood = new List<int>();
        water = new List<int>();
        questionId = new List<int>();
        activity = new List<int>();
        answer = new List<String>();
        note = new List<String>();
        for (Entry entry in entryList) {
          sleep.add(entry.sleep);
          mood.add(entry.mood);
          water.add(entry.water);
          questionId.add(entry.question_id);
          activity.add(entry.activity);
          answer.add(entry.answer);
          note.add(entry.note);
        }
      });
    }
  }

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    Future<List<Entry>> d = databaseHelper.getEntryList();
    d.then((entryList) {
      updateGraphs(entryList);
    });
    return MaterialApp(
      home:
      Scaffold(
        backgroundColor: Colors.lightBlue[200],
        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Mood and Sleeptime',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            genLineGraph([mood, sleep]),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'My Moods',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            genPieGraph(mood),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Water, Sleep, and Mood',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            genLineGraph([water, sleep, mood]),
          ],
        ),
      )

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
