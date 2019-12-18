import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:Speculus/Models/entry.dart';
import 'package:Speculus/Persistence/database.dart';
import 'package:Speculus/Utils/constants.dart';

class SuggestionsPage extends StatefulWidget {
  SuggestionsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final formKey = GlobalKey<FormState>();

  String _rating = '1';
  String _name = '';
  String _suggestion = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          child: Form(
          key: formKey,
          child: new ListView(
            children: getFormWidget(),
      )

    )));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();



    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name';
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value;
        });
      },
    ));

    formWidget.add(new Text(
        'How many stars would you rate our app?'
    ));

    formWidget.add(new Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('1 Star'),
          value: '1',
          groupValue: _rating,
          onChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('2 Stars'),
          value: '2',
          groupValue: _rating,
          onChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('3 Stars'),
          value: '3',
          groupValue: _rating,
          onChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('4 Stars'),
          value: '4',
          groupValue: _rating,
          onChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('5 Stars'),
          value: '5',
          groupValue: _rating,
          onChanged: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
      ],
    ));

    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'How should we improve our app?', hintText: 'Suggestion'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a Suggestion';
        }
      },
      onSaved: (value) {
        setState(() {
          _suggestion = value;
        });
      },
    ));



    formWidget.add( RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          print('The form is valid');
        }
      },
      child: Text('Submit'),
    ));

    return formWidget;

  }

}

    /*
    return Scaffold(
      appBar: AppBar(title: Text('Flutter forms'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Email required';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Name'),
                obscureText: true,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Name required';
                  }
                },
              ),


              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print('The form is valid');
                  }
                },
                child: Text('Submit'),
              ),
            ]
            )),
      ),
    );
}*/