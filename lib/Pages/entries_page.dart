import 'package:flutter/material.dart';
import 'package:Speculus/Persistence/database.dart';
import 'package:Speculus/Models/entry.dart';
import 'package:Speculus/Utils/constants.dart';

class EntriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper();
    return FutureBuilder(
      future: databaseHelper.getEntryList(),
      builder: (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('none');
          case ConnectionState.active:
            return Text('active');
          case ConnectionState.waiting:
            return Text('waiting');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error, please refresh the page');
            }
            return new Scaffold(
              body: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data[i].datetime);
                  return new ExpansionTile(
                      title: new Text(date.month.toString() +
                          "/" +
                          date.day.toString() +
                          "/" +
                          date.year.toString()),
                    children: <Widget>[
                      _genList(snapshot.data[i]),
                    ],
                  );
                },
              ),
            );
        }
        return Text('Error, please refresh the page');
      },
    );
  }

  Widget _genList(Entry e) {
    return new Column(
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
          new SizedBox(height: 10,),
          getTextWidget(Constants.questionsOfTheDay[e.question_id]),
          getTextWidget(e.answer),
          getTextWidget(e.note),
        ],
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
          width: 370,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  Color getColorFromMood(int mood) {
    int calcMood = (mood * 255 / 12).floor();
    if (calcMood < 128) {
      return Color.fromARGB(150, 255, calcMood * 2, 0);
    } else {
      return Color.fromARGB(150, 255 - (calcMood - 128) * 2, 255, 0);
    }
  }
}
