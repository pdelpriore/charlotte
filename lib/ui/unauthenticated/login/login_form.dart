import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextStyle textStyle;
  final TextEditingController controller;
  final bool obscureText;
  final IconData icon;
  final String hintText;
  final TextStyle hintStyle;
  final Color color;

  const LoginForm(
      {Key key,
      @required this.textStyle,
      @required this.controller,
      @required this.obscureText,
      @required this.icon,
      @required this.hintText,
      @required this.hintStyle,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: this.textStyle,
      controller: this.controller,
      obscureText: this.obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(this.icon, color: this.color),
        hintText: this.hintText,
        hintStyle: this.hintStyle,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color),
        ),
      ),
    );
  }
}
