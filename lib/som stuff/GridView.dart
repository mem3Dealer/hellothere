import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hellothere/models/cooltile_class.dart';
import 'package:hellothere/som%20stuff/GridView.dart';

final Random rnd = Random();
const _chars = "AaBbCcDdEeFfGgHhIiJjKkLl MmNnOoPpQqRrSsTtUuVvWwXxYyZz";

void main() {
  runApp(MyApp());

  // var nums4 = List<Cooltile>.generate(
  //     40,
  //     (y) =>
  //         Cooltile(title: randomString(3), subtitle: randNumb(), lead: y + 1));
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

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  // List<Map<String, Object>> nums3;
  List<Cooltile> nums4;
  bool encrease = false;
  bool showit;

  @override
  void initState() {
    super.initState();

    // nums3 = List<Map<String, Object>>.generate(
    //     40, (i) => {'id': i + 1, 'str': randomString(25), 'numb': randNumb()});
    nums4 = List<Cooltile>.generate(
        40,
        (y) =>
            Cooltile(title: randomString(25), subtitle: randNumb(), id: y + 1));
  }

  // void recountNums(int coef) {
  //   encrease = !encrease;
  //   nums3.forEach((e) => encrease
  //       ? ((e['id'] as int).isEven
  //           ? e['numb'] = (e['numb'] as int) * coef
  //           : e['numb'] = (e['numb'] as int) ~/ coef)
  //       : (!(e['id'] as int).isOdd
  //           ? e['numb'] = (e['numb'] as int) ~/ coef
  //           : e['numb'] = (e['numb'] as int) * coef));
  //   setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF26C6DA),
            title: Text("this is appbar, seems to be")),
        body: OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              children: nums4.map((e) {
                return Card(
                  child: ListTile(
                      leading: Text("${e.id}"),
                      title: Text("${e.title}"),
                      subtitle: Text("${e.subtitle}"),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => setState(() {
                                nums4.removeAt(nums4.indexOf(e));
                              }))),
                );
              }).toList());
        }),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
              child: Icon(Icons.all_inclusive_sharp),
              onPressed: () {
                nums4.forEach((e) {
                  e.toggleSubtitle(2, encrease);
                  e.splitTitle();
                }); // потому что е и есть сам объект
                setState(() {
                  encrease = !encrease;
                });
              }),
          FloatingActionButton(
              child: Icon(Icons.auto_awesome), onPressed: () => showit = null),
        ]));
  }

  int randNumb() {
    return rnd.nextInt(100) + 100;
  }

  String randomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));
}
