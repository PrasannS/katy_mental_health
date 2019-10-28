import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:katy_mental_health/Models/entry.dart';
import 'package:katy_mental_health/Persistence/database.dart';
import 'package:katy_mental_health/Utils/constants.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = '';
  DatabaseHelper databaseHelper = DatabaseHelper();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  Widget bottom = new Container(
  height: 300,
  child: RaisedButton(
  child: Text('HI'),
  ),
  );

  void setBottom(DateTime dateTime){
    bottom =  new Container(
      height: 300,
      child: RaisedButton(
        child: Text('HI'),
      ),
    );
    Future<List<Entry>>d = databaseHelper.getEntryList();
    d.then((entryList){
      for(Entry e in entryList){
        if(DateTime.fromMillisecondsSinceEpoch(e.datetime).difference(dateTime).inDays==0){
          bottom = new Container(
            height: 300,
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.airline_seat_flat,
                            semanticLabel: "${e.sleep}",
                          ),
                          Text(
                              '${e.sleep}'
                          )
                        ],
                      ),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color.fromRGBO(255-200, 0, 50,.10), Color.fromRGBO(0, 200, 50,.10)])
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.child_care,
                            semanticLabel: "Hello",
                          ),
                          Text(
                              '${e.mood}'
                          )
                        ],
                      ),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color.fromRGBO(255-200, 0, 50,.10), Color.fromRGBO(0, 200, 50,.10)])
                      ),

                    ),
                    Container(

                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.invert_colors,
                            semanticLabel: "Hello",
                          ),
                          Text(
                              '${e.water}'
                          )
                        ],
                      ),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Color.fromRGBO(255-200, 0, 50,.10), Color.fromRGBO(0, 200, 50,.10)])
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text('${Constants.questionsOfTheDay[e.question_id]}'),
                      height: 50,
                      width: 370,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text('${e.answer}'),
                      height: 50,
                      width: 370,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text('${e.note}'),
                      height: 50,
                      width: 370,
                    // ignore: missing_return
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                )
              ],
            ),
          );
        }
      }
    });
  }
  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));

      },
      daysHaveCircularBorder: null,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      // markedDateIconBuilder: (event) {
      //   return Container(
      //     color: Colors.blue,
      //   );
      // },
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        print(date.toString());
        setBottom(date);
      },
      onDayLongPressed: (DateTime date) {
        setBottom(date);
        print("Long Press");
      },
    );

    return new Scaffold(
        body: SingleChildScrollView(
          child:SizedBox(
            height: 800,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                //custom icon
                //m icon without header
                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            _currentMonth,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          )),
                      FlatButton(
                        child: Text('PREV'),
                        onPressed: () {
                          setState(() {
                            _currentDate2 =
                                _currentDate2.subtract(Duration(days: 30));
                            _currentMonth =
                                DateFormat.yMMM().format(_currentDate2);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text('NEXT'),
                        onPressed: () {
                          setState(() {
                            _currentDate2 = _currentDate2.add(Duration(days: 30));
                            _currentMonth = DateFormat.yMMM().format(_currentDate2);
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 300,
                  child: _calendarCarouselNoHeader,
                ),
                bottom
                //
              ],
            ),
          )
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
