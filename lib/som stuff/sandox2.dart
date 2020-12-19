import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar createTabBar() {
    return TabBar(tabs: <Tab>[
      Tab(icon: Icon(Icons.auto_awesome)),
      Tab(icon: CircleAvatar(backgroundColor: Colors.black45, child: Text('1')))
    ], controller: tabController);
  }

  TabBarView createTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('this is title'),
                backgroundColor: Colors.deepPurpleAccent,
                bottom: createTabBar()),
            body: createTabBarView(
                <Widget>[theGridView().build(), SimpleWidget()])));
  }
}

class SimpleWidget extends StatefulWidget {
  @override
  SimpleWidgetState createState() => SimpleWidgetState();
}

class SimpleWidgetState extends State<SimpleWidget> {
  int stepCounter = 0;
  List<Step> steps = [
    Step(
      title: Text("this is step one"),
      content: Text('do things, man'),
      isActive: true,
    ),
    Step(
      title: Text("this is step two"),
      content: Text('go'),
      isActive: true,
    ),
    Step(
      title: Text("this is step three"),
      content: Text('and fuck'),
      isActive: true,
    ),
    Step(
      title: Text("this is step four"),
      content: Text('yourself'),
      isActive: true,
    )
  ];
  @override
  Widget build(BuildContext ctx) {
    return Container(
        child: Stepper(
      currentStep: this.stepCounter,
      steps: steps,
      type: StepperType.vertical,
      onStepTapped: (step) {
        setState(() {
          stepCounter = step;
        });
      },
      onStepCancel: () {
        setState(() {
          stepCounter > 0 ? stepCounter -= 1 : stepCounter = 0;
        });
      },
      onStepContinue: () {
        setState(() {
          stepCounter < steps.length - 1 ? stepCounter += 1 : stepCounter = 0;
        });
      },
    ));
  }
}

class theGridView {
  Card makeGridCard(String name, IconData icon) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Center(child: Icon(icon)),
          Center(child: Text(name))
        ],
      ),
    );
  }

  GridView build() {
    return GridView.count(
        primary: true,
        padding: EdgeInsets.all(4),
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          makeGridCard('first', Icons.first_page),
          makeGridCard('second', Icons.duo),
          makeGridCard('third', Icons.local_activity),
          makeGridCard('fourth', Icons.add_link),
          makeGridCard('fifth', Icons.opacity),
          makeGridCard('sixth?', Icons.home),
        ]);
  }
}
