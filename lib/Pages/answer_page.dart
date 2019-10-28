import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:katy_mental_health/Models/entry.dart';
import 'package:katy_mental_health/Persistence/database.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<String> questions = ["How Much Sleep did you get?", "What is your mood?","How much water have you drank today?",
    "Question of the Day:","What was your most impactful activity today?", "Any Notes for Today?", "Submit?"];

  List<String> moods = ["Bad","Meh","Good",];

List<String> questionsOfTheDay = [
   "One thing you are grateful for?",
   "Something that made you smile today: ",
   "One thing that made you laugh: ",
   "One person you are thankful for:  ",
   "Five things you would like to do more:  ",
   "Share a childhood memory.",
   "Name three things you do well. ",
   "Write about someone you admire.",
   "What is your favorite hobby?",
   "What is a fact about you that you don’t often share?",
   "What is one thing you dream of doing?",
   "If you could go anywhere in the world, where would it be? ",
   "Favorite moment this week?  ",
   "What is your favorite song right now?",
   "Name a quote to live by. ",
   "How do you relax?  ",
   "What do you feel most strongly about?",
   "Who is a special person in your life right now?  ",
   "What is something you are proud of?  ",
   "What do you love about yourself?  ",
   "What are three of your absolute favorite activities?"
  ];




  final QDController = TextEditingController();
  final noteController = TextEditingController();

  int initTime;
  int inBedTime;
  int days = 0;
  int level = 255;
  int currentQuestion = 0;
  int endTime;
  int qODID = 0;
  int selectedOpt = 0;
  Entry e = new Entry();

  List<int> ends = [0,0,0,254,254,254,254,254,254,254];

  @override
  void initState() {
    super.initState();
    Random r = new Random();
    qODID = r.nextInt(questionsOfTheDay.length-1);
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
      if(currentQuestion!=0)
      currentQuestion--;
    });
  }

  LinearGradient getGradient(int a){
    return new LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color.fromRGBO(255-ends[currentQuestion], 0, 50,1.0), Color.fromRGBO(0, ends[currentQuestion], 50,1.0)]);
  }

  void submit() async{
    e.answer=QDController.text;
    e.activity=selectedOpt;
    e.question_id=qODID;
    e.mood=ends[1];
    e.sleep=ends[0];
    e.water=ends[2];
    e.note=noteController.text;
    e.datetime= new DateTime.now().millisecondsSinceEpoch;
    databaseHelper.insertEntry(e);
    print(e.toString());
    Future<List<Entry>>d = databaseHelper.getEntryList();
    d.then((entryList){
      print(entryList[1].toString());
    });

  }
  @override
  Widget build(BuildContext context) {

    //START OF ALL OF THE QUESTION PAGE LOGIC

    List<Widget> options = [
      FlatButton(
        child: Text('Work'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(1)
        },
      ),
      FlatButton(
        child: Text('Education'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(2)
        },
      ),
      FlatButton(
        child: Text('Relax'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(3)
        },
      ),
      FlatButton(
        child: Text('Family'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(4)
        },
      ),
      FlatButton(
        child: Text('Food'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(5)
        },
      ),
      FlatButton(
        child: Text('Friends'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(5)
        },
      ),
      FlatButton(
        child: Text('ExtraCurricular'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{selected(6)},
      ),
      FlatButton(
        child: Text('Other'),
        color: baseColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: ()=>{
          selected(7)
        },
      ),
    ];

    List<Widget> questionWidgets = [
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
                Text('${((ends[currentQuestion]*24)/255).round()} Hours',
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
                Text('${moods[((ends[currentQuestion]*2.99)/255).floor()]}',
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
              "${questionsOfTheDay[qODID]}"
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
            children: options,
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
                      '${questions[currentQuestion]}',
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
                        child: Text('NEXT'),
                        color: baseColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed:  nextQuestion,
                      ),
                    ]),
                  ],
                )
            )));
  }

}