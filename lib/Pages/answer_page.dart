import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  List<String> questions = ["","How Much Sleep did you get?", "What is your mood?","How much water have you drank today?",
    "Question of the Day:","What was your most impactful activity today?", "Any Notes for Today?", "Submit?"];

  List<String> moods = ["Bad","Meh","Good",];
  int initTime;
  int inBedTime;
  int outBedTime =0;
  int days = 0;
  int level = 255;
  int currentQuestion = 0;
  int endTime;





  @override
  void initState() {
    super.initState();
  }
  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      outBedTime = end;
      days = laps;
      level = end >= 255 ? 255 : end;
    });
  }

  void nextQuestion(){
    setState(() {
      if(currentQuestion!=2) {
        currentQuestion++;
      }
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
        colors: [Color.fromRGBO(255-a, 0, 50,1.0), Color.fromRGBO(0, a, 50, 1.0)]);
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> questionWidgets = [
      new SingleCircularSlider(
        255,
        10,
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
                Text('${((outBedTime*24)/255).round()} Hours',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
      ),
      new SingleCircularSlider(
        255,
        10,
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
                Text('${moods[((outBedTime*2.99)/255).floor()]}',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
      ),
      new SingleCircularSlider(
        255,
        10,
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
                Text('${((outBedTime*8)/255).round()} Glasses',
                    style: TextStyle(fontSize: 24.0, color: Colors.white)),
              ],
            )),
        shouldCountLaps: false,
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
                        child: Text('BACK $days'),
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