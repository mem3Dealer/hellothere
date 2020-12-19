import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Back"),
            onTap: () => Navigator.pushNamed(context, '/'),
          )
        ])),
        appBar:
            AppBar(backgroundColor: Color(0xFF26C6DA), title: Text("About")),
        body: Center(child: Text('THIS IS ABOUT PAGE')));
  }
}
