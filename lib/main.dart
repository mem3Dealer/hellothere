import 'package:flutter/material.dart';
import 'dart:math';

final Random rnd = Random();
const _chars = "AaBbCcDdEeFfGgHhIiJjKkLl MmNnOoPpQqRrSsTtUuVvWwXxYyZz";
const _nums = "1234567890";

void main() {
  // runApp(MyApp());
  print(nums3);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "myapp",
      home: HomePage(),
    );
  }
}

List<Map<String, Object>> nums3 = List<Map<String, Object>>.generate(
    40, (i) => {'id': i + 1, 'str': randomString(25), 'numb': randomNumber(5)});

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
        body: ListView(children: <Widget>[
          Card(
              child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                child: Text('${nums3[0]['id']}')),
            title: Text('${nums3[0]['str']}'),
            subtitle: Text('${nums3[0]['numb']}'),
          )),
          Card(
              child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                child: Text('${nums3[1]['id']}')),
            title: Text('${nums3[1]['str']}'),
            subtitle: Text('${nums3[1]['numb']}'),
          )),
          Card(
              child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                child: Text('${nums3[2]['id']}')),
            title: Text('${nums3[2]['str']}'),
            subtitle: Text('${nums3[2]['numb']}'),
          ))
        ]));
  }
}

dynamic randomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));
// сверху и снизу генераторы
String randomNumber(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _nums.codeUnitAt(rnd.nextInt(_nums.length))));
