import 'package:flutter/material.dart';
import 'package:hellothere/models/cooltile_class.dart';
import 'package:hellothere/providers/primary_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
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
        appBar: AppBar(
            backgroundColor: Color(0xFF26C6DA),
            title: Text("Settings"),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Consumer<CooltilesList>(
                      builder: (context, cl, child) => GestureDetector(
                            onTap: () {
                              cl.purge();
                            },
                            child: Icon(
                              Icons.delete_forever,
                              size: 26.0,
                            ),
                          )))
            ]),
        body: Consumer<CooltilesList>(
            builder: (context, cl, child) => ListView(
                children: cl.secondary.map((e) => _card(e, cl)).toList())));
  }
}

Widget _card(Cooltile e, CooltilesList cl) {
  return Card(
      child: ListTile(
    leading: Text("${e.id}"),
    title: Text("${e.title}"),
    subtitle: Text("${e.subtitle}"),
    trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          cl.removeitBack(ct: e);
        }),
  ));
}
