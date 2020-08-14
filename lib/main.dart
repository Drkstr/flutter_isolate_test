import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

void isolateMethod(String time){
  Timer.periodic(new Duration(seconds: 1), (Timer t) {
    debugPrint("Isolate started at: $time");
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Isolate isolate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            onPressed: startIsolate,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Start Isolate"),
            ),
          ),
          RaisedButton(
            onPressed: stopIsolate,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Stop Isolate"),
            ),
          ),
        ],
      )
    );
  }

  Future<void> startIsolate() async {
    stopIsolate();
    isolate = await Isolate.spawn(isolateMethod, DateTime.now().toIso8601String());
  }

  void stopIsolate(){
    if (isolate != null) {
      debugPrint("Stopping isolate");
      isolate.kill();
      isolate = null;
    }
  }
}


