import 'package:flutter/cupertino.dart';

class MyText {
  static Widget textBold({
    required String text,
    required Color? color,
    required double size,
  }) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: size));
  }
}
