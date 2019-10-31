import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/breathing_page.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          body: Container(
              decoration: BoxDecoration(
                // Box decoration takes a gradient
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Resources"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Resources");
                      },
                    ),
                  ),



                  Card(
                    child: ListTile(
                      leading: Icon(Icons.tv),
                      title: Text("Watch Ads"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Ads");
                      },
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.lightbulb_outline),
                      title: Text("Suggestions"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Suggestions");
                      },
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.wb_sunny),
                      title: Text("Breathing"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                          return new BreathingPage();
                        }));
                      },
                    ),
                  ),

                  ListTile(
                    //spacer
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text("Notifications"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Notifications");
                      },
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Settings");
                      },
                    ),
                  ),


                ],
              )
          )
      );
  }

}

