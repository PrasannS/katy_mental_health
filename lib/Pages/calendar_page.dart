import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/answer_page.dart';

import 'package:table_calendar/table_calendar.dart';
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

  DatabaseHelper databaseHelper = DatabaseHelper();
  Widget bottom ;
  DateTime selectedDate;
  CalendarController _calendarController;

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();

    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    bottom = SizedBox(height: 30,);
  }


  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
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
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 350,
                  child: _buildTableCalendar(),
                ),
                bottom,
                FlatButton(
                  color: Colors.white24,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnswerPage(time:selectedDate.millisecondsSinceEpoch)),
                    );
                    print("hi");
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
                //
              ],
            ),
          )
        ));
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
    );
  }

  Widget getIconWithValue(IconData i, int a){
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            i,
            semanticLabel: "$a",
          ),
          Text(
              '$a'
          )
        ],
      ),
      height: 50,
      width: 120,
    );
  }

  Widget getTextWidget(String s){
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

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      selectedDate = day;
      bottom = SizedBox(height: 30,);
      Future<List<Entry>>d = databaseHelper.getEntryList();
      d.then((entryList){
        for(Entry e in entryList){
          DateTime today = DateTime.fromMillisecondsSinceEpoch(e.datetime);
          if(day.year == today.year && day.month == today.month && day.day == today.day){
            bottom= Container(
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
                  SizedBox(
                    height: 30,
                  ),
                  getTextWidget(Constants.questionsOfTheDay[e.question_id]),
                  getTextWidget(e.answer),
                  getTextWidget(e.note),
                ],
              ),
            );
            break;
          }
        }
      });
    });
  }

}
