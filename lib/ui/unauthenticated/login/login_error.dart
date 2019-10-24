import 'package:flutter/material.dart';
import 'package:flutter_model/ui/theme/app_theme.dart';

class LoginError extends StatelessWidget {
  final String errorText;

  const LoginError({Key key, @required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        this.errorText,
        style: AppTheme.of(context).loginError,
      ),
    );
  }
}
