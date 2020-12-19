import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'package:hellothere/models/cooltile_class.dart';
import 'package:hellothere/providers/primary_provider.dart';

import 'about_page.dart';
import 'settings_page.dart';

final Random rnd = Random();
const _chars = "AaBbCcDdEeFfGgHhIiJjKkLl MmNnOoPpQqRrSsTtUuVvWwXxYyZz";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CooltilesList()),
        ],
        child: MaterialApp(
          title: "myapp",
          initialRoute: '/',
          routes: {
            '/': (contex) => HomePage(),
            'settings_page': (context) => SettingsPage(),
            'about_page': (context) => AboutPage(),
          },
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool encrease = false;
  bool showit;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    var cl = Provider.of<CooltilesList>(context, listen: false);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    if (cl.primary == null || cl.primary.isEmpty)
      cl.generateTiles(); //первичная генерация
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.auto_stories),
            title: Text("About"),
            onTap: () => Navigator.pushNamed(context, 'about_page'),
          ),
          ListTile(
            leading: Icon(Icons.settings_applications),
            title: Text("Settings"),
            onTap: () => Navigator.pushNamed(context, 'settings_page'),
          ),
        ])),
        appBar: AppBar(
            backgroundColor: Color(0xFF26C6DA),
            title: Text("this is Appbar"),
            actions: <Widget>[
              Consumer<CooltilesList>(
                  builder: (context, cl, child) =>
                      Text(cl.secondary?.length.toString() ?? '')),
              Consumer<CooltilesList>(
                  builder: (context, cl, child) => IconButton(
                      icon: cl.grid
                          ? Icon(Icons.format_list_numbered)
                          : Icon(Icons.grid_view),
                      onPressed: () {
                        cl.gridSwap();
                      }))
            ]),
        body: Consumer<CooltilesList>(
            builder: (context, cl, child) => cl.grid
                ? Consumer<CooltilesList>(
                    builder: (context, cl, child) =>
                        OrientationBuilder(builder: (context, orientation) {
                          return GridView.count(
                              crossAxisCount:
                                  orientation == Orientation.portrait ? 2 : 3,
                              children: cl.primary
                                  .map((e) => giveGridTiles(
                                      showit, e, cl, animationController))
                                  .toList());
                        }))
                : Consumer<CooltilesList>(
                    builder: (context, cl, child) => AnimatedList(
                          key: listKey, // без юи ключ бесполезен
                          initialItemCount: cl.primary.length,
                          itemBuilder: (context, index, animation) {
                            return giveTiles(showit, cl, animation, index);
                          },
                        ))),
        floatingActionButton: Consumer<CooltilesList>(
            builder: (context, cl, child) => SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    animatedIconTheme: IconThemeData(size: 22.0),
                    children: [
                      SpeedDialChild(
                          label: 'Shake`em',
                          child: Icon(Icons.all_inclusive_sharp),
                          onTap: () {
                            cl.primary.forEach((e) {
                              e.toggleSubtitle(2, cl.encrease);
                              e.splitTitle();
                            });
                            cl.enreaseSwap();
                            print("da"); // потому что е и есть сам объект
                          }),
                      SpeedDialChild(
                          label: 'anime',
                          child: Icon(Icons.auto_awesome),
                          onTap: () {}),
                      SpeedDialChild(
                          label: 'Add more!',
                          child: Icon(Icons.attach_money),
                          onTap: () {
                            // cl.generateTiles();
                            cl.addTiles(listKey); //addTile()
                          }),
                      SpeedDialChild(
                          label: cl.sorta ? "Filter`em A to Z" : 'Filter Leads',
                          child: cl.sorta
                              ? Icon(Icons.sort_by_alpha)
                              : Icon(Icons.filter_1),
                          onTap: () {
                            cl.sortEmUp();
                          })
                    ])));
  }

  Widget giveTiles(
      bool showit, CooltilesList cl, Animation animation, int index) {
    return showit == null
        ? animatedTile(cl, animation, index)
        : showit
            ? (cl.primary[index].id.isEven
                ? animatedTile(cl, animation, index)
                : Container())
            : (cl.primary[index].id.isOdd
                ? animatedTile(cl, animation, index)
                : Container());
  }

  Widget animatedTile(CooltilesList cl, Animation animation, int index) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: _myTile(cl, index));
  }

  Widget _myTile(CooltilesList cl, int index) {
    Cooltile e = cl.primary[index];
    return Card(
        child: ListTile(
      leading: Text("${e.id}"),
      title: Text("${e.title}"),
      subtitle: Text("${e.subtitle}"),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            listKey.currentState.removeItem(
                index, (_, animation) => animatedTile(cl, animation, index),
                duration: const Duration(milliseconds: 500));
            cl.removeTile(e: e);
            print('length is ${cl.primary.length}');
          }),
    ));
  }

  Widget giveGridTiles(bool showit, Cooltile e, CooltilesList cl,
      AnimationController animationController) {
    return showit == null
        ? gridCard(context, e, cl, animationController)
        : showit
            ? (e.id.isEven
                ? gridCard(context, e, cl, animationController)
                : Container())
            : (e.id.isOdd
                ? gridCard(context, e, cl, animationController)
                : Container());
  }

  Widget gridCard(BuildContext context, Cooltile e, CooltilesList cl,
      AnimationController animationController) {
    return AnimatedBuilder(
        animation: this.animationController,
        builder: (context, child) {
          return Transform.scale(
              scale: animationController.value,
              alignment: Alignment.center,
              child: Card(
                  child: GridTile(
                      header: Row(children: <Widget>[
                        CircleAvatar(
                            child: Text("${e.id}",
                                style: TextStyle(fontWeight: FontWeight.bold)))
                      ]),
                      child: Center(
                        child: Text("${e.title}",
                            style: TextStyle(height: -3, fontSize: 20)),
                      ),
                      footer: GridTileBar(
                          backgroundColor: Colors.deepPurple[400],
                          leading: Text("${e.subtitle}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.cyan[300],
                                  fontWeight: FontWeight.bold)),
                          title: Text(""),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // animationController.reverse(); // ono?
                                cl.removeTile(e: e);
                              })))));
        });
  }
}
