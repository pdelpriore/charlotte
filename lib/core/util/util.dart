import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static String capitalize(String text) {
    return text
        .toLowerCase()
        .split(" ")
        .map((word) => (word.isNotEmpty ?? false)
            ? word[0].toUpperCase() + word.substring(1)
            : word)
        .join(" ");
  }

  static String formatDate(String date) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(date)).toString();
  }

  static String formatDateEnglish(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date).toString();
  }
}

class DeactivateKeyboardFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
