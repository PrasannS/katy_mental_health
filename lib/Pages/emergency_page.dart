import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.yellow[50],
        title: Text("Emergency Call"),
      ),
        backgroundColor: Colors.yellow[50],
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "All Numbers Available 24/7",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              color: Colors.indigo[200],
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  title: Text("Suicide Hotline"),
                  subtitle: Text("1-800-273-8255"),
                  onTap: () => launch("tel:18002738255"),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              color: Colors.indigo[200],
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  title: Text("Emergency"),
                  subtitle: Text("911"),
                  onTap: () => launch("tel:18002738255"),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              color: Colors.indigo[200],
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  title: Text("Katy Connect"),
                  subtitle: Text("(281)234-2326"),
                  onTap: () => launch("tel:2812342326"),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              color: Colors.indigo[200],
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  title: Text("KISD Police"),
                  subtitle: Text("(281)237-4000"),
                  onTap: () => launch("tel:2812374000"),
                ),
              ),
            ),
          ],
        ));
  }
}
