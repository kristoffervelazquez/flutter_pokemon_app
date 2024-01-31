import 'package:flutter/material.dart';

class CustomThemeConfig {
  ThemeData themeData() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue[100],
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ),
      brightness: Brightness.light);
}
