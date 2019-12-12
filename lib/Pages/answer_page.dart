import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:Speculus/Models/entry.dart';
import 'package:Speculus/Persistence/database.dart';
import 'package:Speculus/Utils/constants.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
  final int time;

  AnswerPage({Key key, @required this.time}) : super(key: key);
}

class _AnswerPageState extends State<AnswerPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  DatabaseHelper databaseHelper = DatabaseHelper();

  final QDController = TextEditingController();
  final noteController = TextEditingController();

  int initTime;
  int inBedTime;
  int days = 0;
  int level = 255;
  int currentQuestion = 0;
  int qODID = 0;
  int selectedOpt = 1;
  Entry e = new Entry();

  List<int> ends = [20, 20, 20, 254, 254, 254, 254, 254, 254, 254];
  List<int> levels = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<bool> above = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  double moodEnd = 20.0;

  List<String> colorList = ["5D26C1"
,"#5C27C0"
,"#5C28BF"
,"#5C29BF"
,"#5C2ABE"
,"#5C2CBD"
,"#5C2DBD"
,"#5C2EBC"
,"#5C2FBC"
,"#5C30BB"
,"#5C32BA"
,"#5C33BA"
,"#5C34B9"
,"#5C35B9"
,"#5C36B8"
,"#5C38B7"
,"#5C39B7"
,"#5C3AB6"
,"#5C3BB6"
,"#5C3DB5"
,"#5C3EB4"
,"#5C3FB4"
,"#5C40B3"
,"#5C41B2"
,"#5C43B2"
,"#5C44B1"
,"#5C45B1"
,"#5C46B0"
,"#5C47AF"
,"#5C49AF"
,"#5C4AAE"
,"#5C4BAE"
,"#5C4CAD"
,"#5B4DAC"
,"#5B4FAC"
,"#5B50AB"
,"#5B51AB"
,"#5B52AA"
,"#5B54A9"
,"#5B55A9"
,"#5B56A8"
,"#5B57A8"
,"#5B58A7"
,"#5B5AA6"
,"#5B5BA6"
,"#5B5CA5"
,"#5B5DA4"
,"#5B5EA4"
,"#5B60A3"
,"#5B61A3"
,"#5B62A2"
,"#5B63A1"
,"#5B64A1"
,"#5B66A0"
,"#5B67A0"
,"#5B689F"
,"#5B699E"
,"#5B6B9E"
,"#5B6C9D"
,"#5B6D9D"
,"#5B6E9C"
,"#5B6F9B"
,"#5B719B"
,"#5B729A"
,"#5B739A"
,"#5A7499"
,"#5A7598"
,"#5A7798"
,"#5A7897"
,"#5A7996"
,"#5A7A96"
,"#5A7B95"
,"#5A7D95"
,"#5A7E94"
,"#5A7F93"
,"#5A8093"
,"#5A8292"
,"#5A8392"
,"#5A8491"
,"#5A8590"
,"#5A8690"
,"#5A888F"
,"#5A898F"
,"#5A8A8E"
,"#5A8B8D"
,"#5A8C8D"
,"#5A8E8C"
,"#5A8F8B"
,"#5A908B"
,"#5A918A"
,"#5A928A"
,"#5A9489"
,"#5A9588"
,"#5A9688"
,"#5A9787"
,"#5A9987"
,"#5A9A86"
,"#599B85"
,"#599C85"
,"#599D84"
,"#599F84"
,"#59A083"
,"#59A182"
,"#59A282"
,"#59A381"
,"#59A581"
,"#59A680"
,"#59A77F"
,"#59A87F"
,"#59A97E"
,"#59AB7D"
,"#59AC7D"
,"#59AD7C"
,"#59AE7C"
,"#59B07B"
,"#59B17A"
,"#59B27A"
,"#59B379"
,"#59B479"
,"#59B678"
,"#59B777"
,"#59B877"
,"#59B976"
,"#59BA76"
,"#59BC75"
,"#59BD74"
,"#59BE74"
,"#59BF73"
,"#59C173"];

  @override
  void initState() {
    super.initState();
    Random r = new Random();
    qODID = r.nextInt(Constants.questionsOfTheDay.length - 1);
  }

  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      ends[currentQuestion] = end;
      days = laps;
      levels[currentQuestion] = laps;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestion != 6) {
        currentQuestion++;
      } else {
        submit();
      }
    });
  }

  void selected(int a) {
    setState(() {
      selectedOpt = a;
      print(selectedOpt);
      currentQuestion++;
    });
  }

  void prevQuestion() {
    setState(() {
      if (currentQuestion != 0) {
        currentQuestion--;
      } else {
        Navigator.pop(context);
      }
    });
  }

  LinearGradient getGradient(int a) {
    return new LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          //Color.fromRGBO(50, 0, 255 - ends[currentQuestion], 1.0),
          //Color.fromRGBO(0, ends[currentQuestion], 50, 1.0)
        ]);
  }

  void submit() async {
    e.answer = QDController.text;
    e.activity = selectedOpt;
    e.question_id = qODID;
    e.mood = ((ends[0] * 12) / 255).floor();
    e.sleep = above[1] ? 13 : ((ends[1] * 12) / 255).round();
    e.water = above[2] ? 13 : ((ends[2] * 12) / 255).round();
    e.note = noteController.text;
    if (widget.time == 0)
      e.datetime = new DateTime.now().millisecondsSinceEpoch;
    else
      e.datetime = widget.time;
    databaseHelper.insertEntry(e);
    print(e.toString());
    Future<List<Entry>> d = databaseHelper.getEntryList();
    d.then((entryList) {
      print(entryList[entryList.length - 1].toString());
    });
  }

  List<Widget> getOptions() {
    List<Widget> widgets = new List<Widget>();
    int i = 0;
    for (String s in Constants.questionOptions) {
      widgets.add(new FlatButton(
        child: Text('$s'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () => {selected(Constants.questionOptions.indexOf(s))},
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    String textt = (currentQuestion == 6) ? "SUBMIT" : "NEXT";

    List<Widget> questionWidgets = [
      new SingleCircularSlider(
        255,
        ends[currentQuestion],
        height: 380.0,
        width: 380.0,
        primarySectors: 0,
        secondarySectors: 0,
        baseColor: Color.fromRGBO(255, 255, 255, 0.1),
        selectionColor: Color.fromRGBO(255, 255, 255, 0.3),
        handlerColor: Colors.white,
        sliderStrokeWidth: 50,
        handlerOutterRadius: 12.0,
        onSelectionChange: _updateLabels,
        showRoundedCapInSelection: false,
        showHandlerOutter: true,
        child: Padding(
            padding: const EdgeInsets.all(42.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                    '${Constants.moods[((ends[currentQuestion] * 2.99) / 255).floor()]}',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
      ),
      new Column(
        children: <Widget>[
          Text(
              '${((ends[currentQuestion] * 12) / 255).round()} hours',
              style: TextStyle(fontSize: 24.0, color: Colors.white)),
          FlutterSlider(
            values: [20],
            max: 255,
            min: 0,
            handlerAnimation: FlutterSliderHandlerAnimation(
                curve: Curves.elasticOut,
                reverseCurve: Curves.bounceIn,
                duration: Duration(milliseconds: 500),
                scale: 1.5),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              ends[currentQuestion] = lowerValue.floor();
              setState(() {});
            },
            tooltip: FlutterSliderTooltip(disabled: true),
          )
        ],
      ),


      new SingleCircularSlider(
        255,
        ends[currentQuestion],
        height: 380.0,
        width: 380.0,
        primarySectors: 0,
        secondarySectors: 0,
        baseColor: Color.fromRGBO(255, 255, 255, 0.1),
        selectionColor: Color.fromRGBO(255, 255, 255, 0.3),
        handlerColor: Colors.white,
        sliderStrokeWidth: 50,
        handlerOutterRadius: 12.0,
        onSelectionChange: _updateLabels,
        showRoundedCapInSelection: false,
        showHandlerOutter: true,
        child: Padding(
            padding: const EdgeInsets.all(42.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      above[currentQuestion] = true;
                      ends[currentQuestion] = 255;
                      currentQuestion++;
                    });
                  },
                  child: Text(
                    "12+",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    '${((ends[currentQuestion] * 12) / 255).round() + levels[currentQuestion] * 10} Glasses',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
      ),
      new SizedBox(
          height: 200,
          width: 380,
          child: ListView(
            children: <Widget>[
              Text("${Constants.questionsOfTheDay[qODID]}"),
              TextField(
                controller: QDController,
              ),
            ],
          )),
      new SizedBox(
          height: 380,
          width: 380,
          child: ListView(
            children: getOptions(),
          )),
      new SizedBox(
        height: 200,
        width: 380,
        child: TextField(
          controller: noteController,
        ),
      ),
      new SizedBox(
        height: 200,
        width: 380,
      ),
    ];

    //kms
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(


                   /* color: Color.fromARGB(150, ((161 - (72 * (ends[currentQuestion] / 2.55)))).toInt(),
                        ((127 + (66 * (ends[currentQuestion] / 2.55)))).toInt(), ((224 - (115 * (ends[currentQuestion] / 2.55)))).toInt())),
                    */

                  color: ends[currentQuestion]~/2 < 128 //(ends[currentQuestion]~/2) < colorList.length
                    ? hexToColor(colorList[ends[currentQuestion]~/2])
                  : Color.fromARGB(150, 255, 255, 255)
                ),

/*
                    color: ends[currentQuestion] < 128
                        ? Color.fromARGB(150, 255, ends[currentQuestion] * 2, 0)
                        : Color.fromARGB(150, 255 - (ends[currentQuestion] - 128) * 2, 255, 0)),
  */
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${Constants.questions[currentQuestion]}',
                      style: TextStyle(color: Colors.white),
                    ),
                    questionWidgets[currentQuestion],
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            child: Text('BACK'),
                            color: baseColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: prevQuestion,
                          ),
                          FlatButton(
                            child: Text(textt),
                            color: baseColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () => {
                              setState(() {
                                if (currentQuestion != 6) {
                                  currentQuestion++;
                                } else {
                                  Text('SUBMIT');
                                  submit();
                                  Navigator.pop(context);
                                }
                              })
                            },
                          ),
                        ]),
                  ],
                ))));
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void dispose() {
    super.dispose();
  }
}



