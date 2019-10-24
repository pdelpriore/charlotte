import 'package:flutter/material.dart';

class MyCharges extends StatefulWidget {
  MyCharges({Key key}) : super(key: key);

  @override
  _MyChargesState createState() => _MyChargesState();
}

class _MyChargesState extends State<MyCharges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mes frais",
        ),
      ),
      body: Container(
        child: Text("Welcome to Mes Frais"),
      ),
    );
  }
}