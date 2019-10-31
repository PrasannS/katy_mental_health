import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  _launchURL() async {
    const url = 'https://socialworklicensemap.com/mental-health-resources-list/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          body: Container(
              decoration: BoxDecoration(
                // Box decoration takes a gradient
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    new Color(0xff04a5c1),
                    new Color(0xfff9f981)
                  ],
                ),
              ),
              child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Resources"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        _launchURL();
                      },
                    ),


                  ListTile(
                      leading: Icon(Icons.tv),
                      title: Text("Watch Ads"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Ads");

                      },
                    ),


                  ListTile(
                      leading: Icon(Icons.lightbulb_outline),
                      title: Text("Suggestions"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Suggestions");
                      },
                    ),


                  ListTile(
                      leading: Icon(Icons.wb_sunny),
                      title: Text("Breathing"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Breathing");
                      },
                    ),


                  ListTile(
                    //spacer
                  ),

                  ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text("Notifications"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Notifications");
                      },
                    ),


                  ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Settings");
                      },
                    ),



                ],
              )
          )
      );
  }

}

