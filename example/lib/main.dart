import 'package:flutter/material.dart';
import 'dart:math';

import 'package:gaugeanimated/gaugeanimated.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example gaugeanimated',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Example gaugeanimated'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Driver driver = new Driver();

  void _incrementCounter() {
    setState(() {
      driver.add(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: GaugeAnimated.build(
                driver: driver,
                centerWidget: Text(driver.getValue.toString() + "%"),
                fullColor: Colors.black,
                percentColor: Colors.indigo[400].withOpacity(0.8),
                fullWidth: 4,
                percentWidth: 10,
              ),
            ),
            Container(
                child: GaugeAnimated.build(
                    driver: driver,
                    centerWidget: exampleWidget(),
                    fullColor: Colors.black,
                    percentColor: Colors.red,
                    fullWidth: 10,
                    percentWidth: 4,
                    diameter: 280,
                    percentColorGradient: new SweepGradient(
                      tileMode: TileMode.mirror,
                      colors: [
                        Colors.red,
                        Colors.blue,
                      ],
                      startAngle: 25 * (2 * pi / 60),
                      endAngle: 40 * (2 * pi / 60)
                    ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget exampleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Example Test"),
        Text("Current Percentage: " + driver.getValue.toString() + "%"),
        Text("Change your text"),
      ],
    );
  }
}
