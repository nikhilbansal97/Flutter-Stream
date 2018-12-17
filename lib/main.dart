import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter App"),
        ),
        body: Center(
          child: Counter(),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var count = 0;
  var streamController = StreamController<int>();

  /*
   * Pass the incremented value of the counter to the stream.
   */
  void _incrementCounter() {
    streamController.sink.add(count + 1);
  }

  /*
   * Subscribe to the stream when the state is initialized
   */
  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  void _subscribe() {
    streamController.stream.listen((data) {
      /*
       * Value of mounted boolean will be set to true when the widget will be given a build context
       */
      if (mounted) {
        setState(() {
          count = data;
        });
      }
    });
  }

  /*
   * Close the stream when the widget is destroyed.
   */
  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(count.toString()),
        RaisedButton(
          color: Colors.red,
          textColor: Colors.white,
          child: Text("Update Counter"),
          onPressed: _incrementCounter,
        ),
      ],
    );
  }
}
