import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/answer_page.dart';
import 'package:katy_mental_health/Pages/calendar_page.dart';
import 'package:katy_mental_health/Pages/stats_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(title: "Home Page",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

  List<Widget> _tabList = [
    Container(
      child:StatsPage()
    ),
    Container(
      child: CalendarPage()
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.purple,
    )
  ];

  //int _bottomNavBarIndex = 0;
  TabController _tabController;
  void _tabControllerListener(){
    setState(() {
      _currentIndex = _tabController.index;
    });
  }
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_tabControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_tabControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (currentIndex){
          setState(() {
            _currentIndex = currentIndex;
          });

          _tabController.animateTo(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(
              title: Text("Calendar"),
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              title: Text("Stats"),
              icon: Icon(Icons.folder)
          ),
          BottomNavigationBarItem(
              title: Text("Community"),
              icon: Icon(Icons.settings)
          ),
          BottomNavigationBarItem(
            title: Text("More"),
            icon: Icon(Icons.access_alarm)
          )
        ],
      ),
    );
  }
}