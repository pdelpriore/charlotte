import 'package:flutter/material.dart';
import 'package:flutter_model/core/i18n.dart';

class ServerError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(I18n.of(context).serverError),
    );
  }
}