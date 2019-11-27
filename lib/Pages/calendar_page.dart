import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Speculus/Pages/answer_page.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:Speculus/Models/entry.dart';
import 'package:Speculus/Persistence/database.dart';
import 'package:Speculus/Utils/constants.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key, this.title, this.preview, this.user})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final bool preview;
  final String user;

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  DateTime selectedDate;
  CalendarController _calendarController;
  final Firestore _firestore = Firestore.instance;
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);
  List<Widget> entries = new List<Widget>();
  List<Entry> entryList = new List<Entry>();
  int refreshState = 0;
  int currentmood = 190;
  @override
  void dispose() {
    _calendarController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    selectedDate = DateTime.now();
    String s = widget.user;
    print(s);
    _firestore
        .collection('calendars')
        .document(s)
        .collection('entries')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents)
        entryList.add(new Entry.fromMap2(ds.data));
      print(snapshot.documents.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    return new Scaffold(
        body: SingleChildScrollView(
            child: Container(
          height: 900,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: getGradient(currentmood),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: 30,
          ),
              //custom icon
              //m icon without header
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0), //16
                child: _buildTableCalendar(),
              ),
              Column(
                children: entries,
              ),

              /*
                FlatButton(
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnswerPage(time:selectedDate.millisecondsSinceEpoch)),
                    );
                    _onDaySelected(selectedDate, null);
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(30.0),
                    child: const Icon(Icons.add
                    ),
                  ),
                ),
                */
              //
            ],
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.grey[200],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AnswerPage(time: selectedDate.millisecondsSinceEpoch)),
            ).then((value)
            {
              _onDaySelected(selectedDate, null);
            });
          },
          child: Icon(Icons.add),
          elevation: 2.0,
        ));
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
        color: Colors.amber,
      )),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
          selectedColor: Colors.blueAccent[400],
          todayColor: Colors.blue[200],
          markersColor: Colors.blueAccent[700],
          outsideDaysVisible: false,
          weekendStyle: TextStyle(
            color: Colors.amber,
          )),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.blueAccent[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
    );
  }

  Widget getIconWithValue(IconData i, int a) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            i,
            semanticLabel: "$a",
          ),
          Text('$a')
        ],
      ),
      height: 50,
      width: 120,
    );
  }

  Widget getTextWidget(String s) {
    return Row(
      children: <Widget>[
        Container(
          child: Text('$s'),
          height: 50,
          width: 370,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  LinearGradient getGradient(int a) {
    return new LinearGradient(
        begin: Alignment.topRight, end: Alignment.bottomLeft,

        //colors: [Color.fromRGBO(255-a, 0, 50,.5), Color.fromRGBO(0,a, 50,0.5)]);
        colors: [new Color(0xff04a5c1), Colors.white]);
  }

  void openEntry(Entry e) {
    setState(() {
      currentmood = e.mood;
      entries = new List<Widget>();
      entries.add(new Container(
        height: 400,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                getIconWithValue(Icons.airline_seat_flat, e.sleep),
                getIconWithValue(Icons.child_care, e.mood),
                getIconWithValue(Icons.invert_colors, e.water),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            new RaisedButton(
              child: Text('${Constants.questionOptions[e.activity]}'),
              color: Color.fromRGBO(255, 255, 255, .5),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            getTextWidget(Constants.questionsOfTheDay[e.question_id]),
            getTextWidget(e.answer),
            getTextWidget(e.note),
          ],
        ),
      ));
    });
  }


  void getEntriesFromFB() {
    _firestore
        .collection('calendars')
        .document(widget.user)
        .collection("entries")
        .getDocuments()
        .then((snapshot) {
      List<Entry> elist = new List<Entry>();
      for (DocumentSnapshot ds in snapshot.documents)
        elist.add(new Entry.fromMap(ds.data));
      return elist;
    });
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      selectedDate = day;
      if (!widget.preview) {
        entries = new List<Widget>();
        Future<List<Entry>> d = databaseHelper.getEntryList();
        d.then((entryList) {
          print(entryList[entryList.length - 1]);
          for (Entry e in entryList) {
            DateTime today = DateTime.fromMillisecondsSinceEpoch(e.datetime);
            if (day.year == today.year &&
                day.month == today.month &&
                day.day == today.day) {
              entries.add(new RaisedButton(
                child: Text('${Constants.questionOptions[e.activity]}'),
                color: Color.fromRGBO(255 - e.mood, e.mood, 50, .5),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                onPressed: () => {openEntry(e)},
              ));
            } else {
              currentmood = 150;
            }

          }
        });
      } else {
        print("other USER");
        entries = new List<Widget>();
        for (Entry e in entryList) {
          DateTime today = DateTime.fromMillisecondsSinceEpoch(e.datetime);
          if (day.year == today.year &&
              day.month == today.month &&
              day.day == today.day) {
            entries.add(new RaisedButton(
              child: Text('${Constants.questionOptions[e.activity]}'),
              color: Color.fromRGBO(255 - e.mood, e.mood, 50, .5),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              onPressed: () => {openEntry(e)},
            ));
          } else {
            currentmood = 150;
          }
        }
      }
    });
  }


  int getAvgMood(DateTime day) {
    selectedDate = day;
    entries = new List<Widget>();
    int total = 0;
    int i = 0;
    Future<List<Entry>> d = databaseHelper.getEntryList();
    d.then((entryList) {
      for (Entry e in entryList) {
        DateTime today = DateTime.fromMillisecondsSinceEpoch(e.datetime);
        if (day.year == today.year &&
            day.month == today.month &&
            day.day == today.day) {
          i++;
          total += e.mood;
          entries.add(new RaisedButton(
            child: Text('${Constants.questionOptions[e.activity]}'),
            color: Color.fromRGBO(255 - e.mood, e.mood, 50, .5),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            onPressed: () => {openEntry(e)},
          ));
        } else {
          currentmood = 150;
        }
      }
    });
    if (i > 0)
      return (total / i).round();
    else {
      return -1;
    }
  }
}
