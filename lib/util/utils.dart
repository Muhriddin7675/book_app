import 'package:flutter/material.dart';

typedef Callback<T> = void Function(T value);

Color redColor = const Color(0xFFF26B6C);
Color tintColor = const Color(0xFF787878);

final categoryColors = [
  const Color(0xFFF26B6C),
  const Color(0xFF219653),
  const Color(0xFFF2C94C),
  const Color(0xFF2F80ED),
  const Color(0xFFED712F),
  const Color(0xFF2FEDCA),
];

class CurrentUser {
  static bool isLogin = false;
  static String userName = '';
  static String email = '';
  static String photo = '';
}

enum Status {
  LOADING,
  ERROR,
  SUCCESS
}

SnackBar getSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    backgroundColor: redColor,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
}