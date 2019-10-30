import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          body: new ListView(
            children: <Widget>[
              Container(
                child: ListTile(
                  leading: Icon(Icons.book),
                  title: Text("Resources"),
                  subtitle: Text("Helpful sources"),
                  onTap: () {
                    debugPrint("Resources");
                  },
                ),
              ),

              Container(
                child: ListTile(
                leading: Icon(Icons.alarm),
                title: Text("Watch Ads"),
                onTap: () {
                  debugPrint("Ads");
                },
              )
              ),



              ListTile(
                leading: Icon(Icons.lightbulb_outline),
                title: Text("Suggestions"),
                onTap: () {
                  debugPrint("Suggestions");
                },
              ),

              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text("Breathing"),
                onTap: () {
                  debugPrint("Breathing");
                },
              ),
              ListTile(
                //spacer
              ),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  debugPrint("Settings");
                },
              ),
            ],
          )
      );
  }

}

