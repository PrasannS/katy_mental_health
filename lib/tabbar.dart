import 'package:flutter/material.dart';

void main() => runApp(TabsApp());

class TabsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs App',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  List<Widget> containers = [
    Container(
      color: Colors.pink,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.deepPurple,
    ),
    Container(
      color: Colors.green,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabs'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Stats',
              ),
              Tab(
                text: 'Community',
              ),
              Tab(
                text: 'More',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}