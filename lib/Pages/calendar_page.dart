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
  List<Entry> entryList = new List<Entry>();
  int refreshState = 0;
  int currentmood = 190;
  bool hasEntries = false;
  int avgMood = 150;

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
    _firestore
        .collection('calendars')
        .document(s)
        .collection('entries')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents)
        entryList.add(new Entry.fromMap2(ds.data));
      _onDaySelected(selectedDate, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build: " + hasEntries.toString());
    return FutureBuilder(
      future: databaseHelper.getEntryList(),
      builder: (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
            return Text("Active...");
          case ConnectionState.waiting:
            return new Scaffold(
              body: SingleChildScrollView(
                  child: Container(
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
                  ],
                ),
              )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: hasEntries == false
                  ? FloatingActionButton(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.grey[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnswerPage(
                                  time: selectedDate.millisecondsSinceEpoch)),
                        ).then((value) {
                          _onDaySelected(selectedDate, null);
                        });
                      },
                      child: Icon(Icons.add),
                      elevation: 2.0,
                    )
                  : Container(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return new Scaffold(
              body: SingleChildScrollView(
                  child: Container(
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
                      children: getEntriesForDay(snapshot.data),
                    )
                  ],
                ),
              )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: hasEntries == false
                  ? FloatingActionButton(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.grey[200],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnswerPage(
                                  time: selectedDate.millisecondsSinceEpoch)),
                        ).then((value) {
                          _onDaySelected(selectedDate, null);
                        });
                      },
                      child: Icon(Icons.add),
                      elevation: 2.0,
                    )
                  : Container(),
            );
        }
        return Text("what"); // unreachable
      },
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      daysOfWeekStyle:
          DaysOfWeekStyle(weekendStyle: TextStyle(color: Colors.black38)),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
          selectedColor: getDayGradient(),
          todayColor: Colors.blue[200],
          outsideDaysVisible: false,
          weekendStyle: TextStyle(color: Colors.black)),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.indigo,
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

  Widget openEntry(Entry e) {
    currentmood = (e.mood * 255 / 12).floor();
    print("MOOD" + e.mood.toString());
    return new Container(
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
            color: getColorFromMood(e.mood),
            textColor: Colors.white,
            onPressed: () {print("pressed");},
            //shape: RoundedRectangleBorder(
            //borderRadius: BorderRadius.circular(40.0),
            //),
          ),
          getTextWidget(Constants.questionsOfTheDay[e.question_id]),
          getTextWidget(e.answer),
          getTextWidget(e.note),
        ],
      ),
    );
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
    });
    print("Finish day selected");
  }

  List<Widget> getEntriesForDay(List<Entry> givenEntries) {
    if (!widget.preview) {
      List<Widget> genEntries = new List<Widget>();
      hasEntries = givenEntries.length > 0;
      print("getEntries: " + hasEntries.toString());
      for (Entry e in givenEntries) {
        DateTime today = DateTime.fromMillisecondsSinceEpoch(e.datetime);
        if (selectedDate.year == today.year &&
            selectedDate.month == today.month &&
            selectedDate.day == today.day) {
          genEntries.add(openEntry(e));
        } else {
          currentmood = 150;
        }
      }
      hasEntries = genEntries.length > 0;
      return genEntries;
    } else {
      print("other USER");
      List<Widget> genEntries = new List<Widget>();
      for (Entry e in entryList) {
        DateTime today = DateTime.fromMillisecondsSinceEpoch(e.datetime);
        if (selectedDate.year == today.year &&
            selectedDate.month == today.month &&
            selectedDate.day == today.day) {
          genEntries.add(openEntry(e));
        } else {
          currentmood = 150;
        }
      }
      return genEntries;
    }
  }

  Color getColorFromMood(int mood) {
    int calcMood = (mood * 255 / 12).floor();
    if (calcMood < 128) {
      return Color.fromARGB(150, 255, calcMood * 2, 0);
    } else {
      return Color.fromARGB(150, 255 - (calcMood - 128) * 2, 255, 0);
    }
  }

  Color getDayGradient() {
    if (avgMood < 128) {
      return Color.fromARGB(150, 255, avgMood * 2, 0);
    } else {
      return Color.fromARGB(150, 255 - (avgMood - 128) * 2, 255, 0);
    }
  }
}
