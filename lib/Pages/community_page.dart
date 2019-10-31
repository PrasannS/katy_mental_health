import 'package:cloud_firestore/cloud_firestore.dart';
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



  final Firestore _firestore = Firestore.instance;

  List<Widget> chats= new List<Widget>();

  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    getChats();
    super.initState();
  }

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
        child: new Column(
          children:chats,
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  void getChats() {
    chats.add(
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
      ),);
    chats.add(
      Card(
        child: ListTile(
          leading: Icon(Icons.add),
          title: Text("Add Chats"),
          onTap: () {
            print(chats.toString());
          },
        ),
      ),
    );
    chats.add(
      ListTile(
        //spacer
      ),
    );
    _firestore
        .collection("chats")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for(DocumentSnapshot d in snapshot.documents){
        setState(() {
          if(d.data['user1']==widget.user){
            String s = d.data['user2'];
            chats.add(
              Card(
                child: ListTile(
                  title: Text("$s"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chat(user:widget.user)),
                    );
                  },
                ),
              ),
            );
          } else {
            if(d.data['user2']==widget.user){
              String s = d.data['user1'];
              chats.add(
                Card(
                  child: ListTile(
                    title: Text("$s"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chat(user:widget.user)),
                      );
                    },
                  ),
                ),
              );
            }
          }

        });

      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}