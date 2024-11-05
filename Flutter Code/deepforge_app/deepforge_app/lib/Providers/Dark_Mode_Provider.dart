import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DarkMode with ChangeNotifier {
  var _darktheme = ThemeMode.light;
  ThemeMode get themeMode => _darktheme;

  void themMode() {
    _darktheme =
        _darktheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
