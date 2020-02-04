import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class MinigamesPage extends StatefulWidget {
  @override
  _MinigamesPageState createState() => _MinigamesPageState();

  MinigamesPage({Key key}) : super(key: key);
}

class _MinigamesPageState extends State<MinigamesPage> {
  int clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minigames"),
      ),
      body: Center(
          child: RaisedButton(
        color: Colors.deepPurple[200],
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(40.0),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 4,
          child: Center(
            child: Text(
              clicks.toString(),
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            clicks++;
          });
        },
      )),
    );
  }
}

class bubble extends StatefulWidget {
  createState() => _bubble();
}

class _bubble extends State<bubble> with SingleTickerProviderStateMixin {
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
  }

  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BubbleAnimation(
            controller: controller,
          ),
        ]);
  }
}

class BubbleAnimation extends StatelessWidget {
  BubbleAnimation({Key key, this.controller})
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
                heroTag: (new Random()).nextInt(1000000).toString(),
                child: Icon(
                  Icons.add_circle,
                  size: 50,
                ),
                onPressed: controller.isAnimating ? null : _start,
                foregroundColor: Colors.blue,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ]);
        });
  }

  Future _start() async {
    try {
      controller.duration = Duration(milliseconds: 4000);
      await controller
          .forward(from: 0.0) // start paper animation over
          .orCancel;
    } on TickerCanceled {}
  }

  _stop() {}
}
