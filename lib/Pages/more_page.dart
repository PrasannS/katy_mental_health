import 'package:Speculus/Pages/emergency_page.dart';
import 'package:Speculus/Pages/entries_page.dart';
import 'package:Speculus/Pages/minigames_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Speculus/Pages/breathing_page.dart';
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
                  //colors: [new Color(0xff04a5c1), Colors.grey[200]],
                    colors: [new Color(0xff7F7FD5), new Color(0xff91EAE4)],
                ),
              ),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.compare_arrows),
                    title: Text("Emergency"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmergencyPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text("See All Entries"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EntriesPage()),
                      );
                    },
                  ),
                  ListTile(
                      leading: Icon(Icons.book),
                      title: Text("Resources", style: TextStyle(fontFamily: 'Roboto')),
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
                    leading: Icon(Icons.gamepad),
                    title: Text("Play Game"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MinigamesPage()),
                      );
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

