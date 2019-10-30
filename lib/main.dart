import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/answer_page.dart';
import 'package:katy_mental_health/Pages/breathing_page.dart';
import 'package:katy_mental_health/Pages/calendar_page.dart';
import 'package:katy_mental_health/Pages/root_page.dart';
import 'package:katy_mental_health/Pages/community_page.dart';
import 'package:katy_mental_health/Pages/stats_page.dart';
import 'package:katy_mental_health/Utils/auth.dart';

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
      home: RootPage(auth: new Auth(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.userid}) : super(key: key);
  final String title;
  final String userid;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;


  //int _bottomNavBarIndex = 0;
  TabController _tabController;
  void _tabControllerListener(){
    setState(() {
      _currentIndex = _tabController.index;
    });
  }
  List<Widget> _tabList;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_tabControllerListener);
    _tabList = [
      Container(
          child:new CalendarPage()
      ),
      Container(
          child:new StatsPage()
      ),
      Container(
        child: new CommunityPage(user:widget.userid),
      ),
      Container(
        child: new BreathingPage(),
      )
    ];
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
      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.redAccent,
        selectedItemColor: Colors.blue,
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