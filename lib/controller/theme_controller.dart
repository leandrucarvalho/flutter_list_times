import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController with ChangeNotifier {
  var _isDark = false;

  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  SharedPreferences? prefs;

  ThemeController() {
    initPrefs();
  }

  bool get isDark => _isDark;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _isDark = prefs?.getBool('isDark') ?? false;
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    prefs?.setBool('isDark', _isDark);
    notifyListeners();
  }
}
