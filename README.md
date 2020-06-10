# gaugeanimated
A flutter plugin to facilitate the creation of graphic gauge.

![Example use](https://raw.githubusercontent.com/keinou/gauge_animated/master/example/img/gauge_animated1.png)

## Getting Started

You should ensure that you add the following dependency in your Flutter project.

```yaml
dependencies:
 gaugeanimated: ^0.6.2
```

You should then run  `flutter packages upgrade`  or update your packages in IntelliJ.

In your Dart code, to use it:

```dart
import 'package:gaugeanimated/gaugeanimated.dart';
```
## Example

An example can be found in the `example` folder. Check it out.
```dart
import 'package:flutter/material.dart';
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
                percentWidth: 10),
            ),
            Container(
              child: GaugeAnimated.build(
                driver: driver,
                centerWidget: exampleWidget(),
                fullColor: Colors.black,
                percentColor: Colors.red,
                fullWidth: 15,
                percentWidth: 4),
            )
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

  Widget exampleWidget(){
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
```