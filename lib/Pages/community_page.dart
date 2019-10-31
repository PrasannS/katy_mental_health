import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key key, this.title, this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String user;

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  void addChat() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  List<Widget> chats = new List<Widget>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.blur_circular),
                title: Text("Global Chat"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chat(user:widget.user)),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text("Add Random Chat"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chat(user:widget.user)),
                  );
                },
              ),
            ),

            ListTile(
              //spacer
            ),
            Container(
              height: 500,
              child: ListView(
                children: chats,
              ),
            ),


          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}