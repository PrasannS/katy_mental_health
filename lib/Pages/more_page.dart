import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katy_mental_health/Pages/breathing_page.dart';
import 'package:link/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  _launchURLRESOURCES() async {
    const url = 'https://socialworklicensemap.com/mental-health-resources-list/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLSUGGESTIONS() async {
    const url = 'https://forms.gle/EhijUFx9kWpay9MEA';
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
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [new Color(0xff04a5c1), Colors.grey[200]],
                ),
              ),
              child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Resources"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        _launchURLRESOURCES();
                      },
                    ),

/*
                  ListTile(
                      leading: Icon(Icons.tv),
                      title: Text("Watch Ads"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Ads");

                      },
                    ),
*/

                  ListTile(
                      leading: Icon(Icons.lightbulb_outline),
                      title: Text("Suggestions"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        debugPrint("Suggestions");
                        _launchURLSUGGESTIONS();
                      },
                    ),


                  ListTile(
                      leading: Icon(Icons.wb_sunny),
                      title: Text("Breathing"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BreathingPage()),
                        );
                      },
                    ),


                  ListTile(
                    //spacer
                  ),

                  /*
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

*/

                ],
              )
          )
      );
  }

}

