import 'package:flutter/material.dart';

class TimeTracking extends StatefulWidget {
  TimeTracking({Key key}) : super(key: key);

  @override
  _TimeTrackingState createState() => _TimeTrackingState();
}

class _TimeTrackingState extends State<TimeTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TimeTracking",
        ),
      ),
      body: Container(
        child: Text("Welcome to TimeTracking Page"),
      ),
    );
  }
}