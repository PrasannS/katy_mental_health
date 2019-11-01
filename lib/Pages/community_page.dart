import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katy_mental_health/Models/entry.dart';
import 'package:katy_mental_health/Pages/private_chat_page.dart';
import 'package:katy_mental_health/Persistence/database.dart';
import 'chat_page.dart';
import 'package:uuid/uuid.dart';

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
  DatabaseHelper databaseHelper = DatabaseHelper();

  void addCalendartoDB(){
    _firestore.collection('calendars').document(widget.user).collection("entries").getDocuments().then((snapshot){
      for (DocumentSnapshot ds in snapshot.documents)
        ds.reference.delete();

      CollectionReference v = _firestore.collection('calendars').document(widget.user).collection("entries");
      Future<List<Entry>>d = databaseHelper.getEntryList();
      d.then((entryList){
        print(entryList.toString());
        print("HERE");
        for(Entry e in entryList){
          v.add(e.toMap());
        }
      });
    });
  }


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

  Future addChat(BuildContext context) async {
    String email = await _asyncInputDialog(context);
    Uuid uid = new Uuid();
    String s = uid.v1();
    if(email.length>0)
    await _firestore.collection('chats').add({
      'user1':widget.user,
      'user2':email,
      'chatid':s,
      'calendarshare':0
    });
    getChats();
  }



  void getChats() {
    chats.clear();
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
            addChat(context);
          },
        ),
      ),
    );
    chats.add(
      Card(
        child: ListTile(
          leading: Icon(Icons.add),
          title: Text("Add Calendar to DB"),
          onTap: () {
            addCalendartoDB();
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
                      MaterialPageRoute(builder: (context) => PrivateChat(user:widget.user, to:d.data[s], toId: d.data['chatid'],)),
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
                        MaterialPageRoute(builder: (context) => PrivateChat(user:widget.user, to:d.data[s], toId: d.data['chatid'],)),
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

  Future<String> _asyncInputDialog(BuildContext context) async {
    String teamName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter email'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Email', hintText: 'eg. example@gmail.com'),
                    onChanged: (value) {
                      teamName = value;
                    },
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}