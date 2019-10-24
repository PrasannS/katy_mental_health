import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class AnswerPage extends StatefulWidget {
  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  int initTime;

  int inBedTime;
  int outBedTime;
  int days = 0;
  int level = 255;

  @override
  void initState() {
    super.initState();
  }
  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      outBedTime = end;
      days = laps;
      level = end;
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
                      'How long did you stay in bed?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SingleCircularSlider(
                      255,
                      10,
                      height: 380.0,
                      width: 380.0,
                      primarySectors: 6,
                      secondarySectors: 24,
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
                              Text('Emoji',
                                  style: TextStyle(fontSize: 24.0, color: Colors.white)),
                            ],
                          )),
                      shouldCountLaps: false,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

                    ]),
                    FlatButton(
                      child: Text('N E X T'),
                      color: baseColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ],
                )
            )));

  }

}