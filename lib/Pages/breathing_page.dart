import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreathingPage extends StatefulWidget {
  BreathingPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _BreathingPageState createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  @override
  String time;
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        home: Scaffold(body: SizedBox.expand(child: breathingButton())));
  }
}

class breathingButton extends StatefulWidget {
  createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<breathingButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
  }

  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(4, 40, 0, 0),
        child: Row(
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)},
            )
          ],
        ),
      ),
      BreathingAnimation(
        controller: controller,
      ),
      AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Text(
              timerString,
              style: TextStyle(
                  fontSize: 112.0,
                  color: controller.isAnimating
                      ? Colors.indigo
                      : Colors.transparent),
            );
          }),
    ]);
  }

  String get timerString {
    Duration duration =
        controller.duration * controller.value + Duration(seconds: 1);
    if (duration.inSeconds == 8) return '';
    return '${duration.inSeconds}';
  }
}

class BreathingAnimation extends StatelessWidget {
  BreathingAnimation({Key key, this.controller})
      : scale = Tween<double>(
          begin: 0.0,
          end: 3.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(alignment: Alignment.center, children: [
            Transform.scale(
              scale: scale.value + 3,
              child: FloatingActionButton(
                child: Icon(
                  Icons.favorite,
                  size: 50,
                ),
                onPressed: _start,
                foregroundColor: Colors.red,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ]);
        });
  }

  Future _start() async {
    try {
      for (int i = 0; i < 3; i++) {
        controller.duration = Duration(milliseconds: 4000);
        await controller
            .forward(from: 0.0) // start paper animation over
            .orCancel;
        controller.duration = Duration(milliseconds: 7000);
        await controller.reverse(from: 3.0).orCancel;
      }
    } on TickerCanceled {}
  }

  _stop() {
    controller.reverse();
    _start();
  }
}
