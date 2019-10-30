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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        home: Scaffold(
      body: SizedBox.expand(child: breathingButton()),
    ));
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
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  Widget build(BuildContext context)
  {
    return BreathingAnimation(controller: controller,);
  }

}

class BreathingAnimation extends StatelessWidget{
  final AnimationController controller;


  BreathingAnimation({Key key, this.controller}) : super(key: key);

  build(context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.forward),
              onPressed: _start,
            )
          ],
        );
      },
    );
  }

  _start() {
    controller.forward();
  }

  _stop() {
    controller.reverse();
  }
}