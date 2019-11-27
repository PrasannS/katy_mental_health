import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:Speculus/Models/entry.dart';
import 'package:Speculus/Persistence/database.dart';
import 'package:Speculus/Utils/constants.dart';

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
  int endTime;
  int qODID = 0;
  int selectedOpt = 1;
  Entry e = new Entry();

  List<int> ends = [0,0,0,254,254,254,254,254,254,254];

  @override
  void initState() {
    super.initState();
    Random r = new Random();
    qODID = r.nextInt(Constants.questionsOfTheDay.length-1);
    print(widget.time);
  }

  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      ends[currentQuestion] = end;
      days = laps;
      level = end >= 255 ? 255 : end;
    });
  }

  void nextQuestion(){
    setState(() {
      if(currentQuestion!=6) {
        currentQuestion++;
      }
      else{
        submit();
      }
    });
  }

  void selected(int a ){
    setState(() {
      selectedOpt=a;
      print(selectedOpt);
      currentQuestion++;
    });
  }

  void prevQuestion(){
      setState(() {
      if(currentQuestion!=0) {
        currentQuestion--;
      } else {
        Navigator.pop(context);
      }
    });
  }

  LinearGradient getGradient(int a){
    return new LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color.fromRGBO(50, 0, 255-ends[currentQuestion],1.0), Color.fromRGBO(0, ends[currentQuestion], 50,1.0)]);
  }

  void submit() async{
    e.answer=QDController.text;
    e.activity=selectedOpt;
    e.question_id=qODID;
    e.mood=ends[0];
    e.sleep=ends[1];
    e.water=ends[2];
    e.note=noteController.text;
    if(widget.time==0)
    e.datetime= new DateTime.now().millisecondsSinceEpoch;
    else
      e.datetime=widget.time;
    databaseHelper.insertEntry(e);
    print(e.toString());
    Future<List<Entry>>d = databaseHelper.getEntryList();
    d.then((entryList){
      print(entryList[entryList.length-1].toString());
    });

  }


  List<Widget> getOptions(){

    List<Widget> widgets = new List<Widget>();
    int i = 0;
    for(String s in Constants.questionOptions){
      widgets.add(
        new FlatButton(
          child: Text('$s'),
          color: baseColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          onPressed: ()=>{
            selected(Constants.questionOptions.indexOf(s))
          },
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
                Text('${Constants.moods[((ends[currentQuestion]*2.99)/255).floor()]}',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
      ),
      new SingleCircularSlider(
        255,
        20,
        height: 380.0,
        width: 380.0,
        primarySectors: 0,
        secondarySectors: 0,
        baseColor: Color.fromRGBO(255, 255, 255, 0.1),
        selectionColor: baseColor,
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
                Text('${((ends[currentQuestion]*12)/255).round()} Hours',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
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
                SizedBox(height: 20),
                Text('${((ends[currentQuestion]*8)/255).round()} Glasses',
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
            Text(
              "${Constants.questionsOfTheDay[qODID]}"
            ),
            TextField(
              controller: QDController,
            ),
          ],
        )
      ),
      new SizedBox(
          height: 380,
          width: 380,
          child: ListView(
            children: getOptions(),
          )
      ),
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

    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    gradient:getGradient(level),
                    color: Color.fromARGB(100, level, 20, 20)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${Constants.questions[currentQuestion]}',
                      style: TextStyle(color: Colors.white),
                    ),
                    questionWidgets[currentQuestion],
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      FlatButton(
                        child: Text('BACK'),
                        color: baseColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: prevQuestion ,
                      ),
                      FlatButton(
                        child: Text(textt),
                        color: baseColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed:  ()=>{
                          setState(() {
                            if(currentQuestion!=6) {
                              currentQuestion++;
                            }
                            else{
                              Text('SUBMIT');
                              submit();
                              Navigator.pop(context);
                            }
                          })
                        },
                      ),
                    ]),
                  ],
                )
            )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}