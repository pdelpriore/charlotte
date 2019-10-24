import 'package:flutter/material.dart';

class Meeting extends StatefulWidget {
  Meeting({Key key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Text("Welcome to Réunion"),
          ),
        )
    );
  }
}