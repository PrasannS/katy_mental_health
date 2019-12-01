import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Speculus/Models/entry.dart';
import 'package:Speculus/Persistence/database.dart';
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
  List<int> date = new List<int>();
  List<String> answer = new List<String>(), note = new List<String>();

  void updateGraphs(List<Entry> entryList) {
    entryList.sort((a, b) => a.datetime.compareTo(b.datetime));
    if (mounted) {
      setState(() {
        sleep = new List<int>();
        mood = new List<int>();
        water = new List<int>();
        questionId = new List<int>();
        activity = new List<int>();
        date = new List<int>();
        answer = new List<String>();
        note = new List<String>();
        for (Entry entry in entryList) {
          sleep.add(entry.sleep);
          mood.add(entry.mood);
          water.add(entry.water);
          questionId.add(entry.question_id);
          activity.add(entry.activity);
          date.add(entry.datetime);
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
    List<int> holdMood = new List<int>();
    for (int i = 0; i < mood.length; i++)
      holdMood.add(mood[i]);
    return MaterialApp(
        home: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [new Color(0xff04a5c1), Colors.grey[300]])),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Mood and Sleeptime',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            genLineGraph(date, [mood, sleep], ["mood", "sleep"]),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'My Moods',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            genPieGraph(holdMood),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Water',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            genLineGraph(date, [mood, water], ["mood", "water"]),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Impactful Activities',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                )),
            BarChartSample1(data: activity),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
