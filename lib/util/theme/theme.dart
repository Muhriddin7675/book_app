import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightMode = ThemeData(
      brightness: Brightness.light,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF212121)),
        bodyMedium: TextStyle(color: Color(0xFF4F4F4F)),
        bodySmall: TextStyle(color: Color(0xFF787878)),
      ),
      colorScheme: const ColorScheme.light(
          background: Color(0xfff5f5f5),
          onBackground: Colors.white,
          primary: Color(0xffc2c2c2),
          secondary: Color(0xFFFFE4E4),
          onSecondary: Color(0xffffffff),
          tertiary: Color(0xffdcdcdc),
          onTertiary: Color(0xffefefef)
      )
  );

  static ThemeData darkMode = ThemeData(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFFFFFFF)),
        bodyMedium: TextStyle(color: Color(0xFFEEEEEE)),
        bodySmall: TextStyle(color: Color(0xFFD0D0D0)),
      ),
      colorScheme: const ColorScheme.dark(
          background: Color(0xff2c2c2c),
          onBackground: Colors.black,
          primary: Color(0xff606060),
          secondary: Color(0xFF4B4B4B),
          tertiary: Color(0xff595959),
          onTertiary: Color(0xff3a3a3a)
      )
  );
}