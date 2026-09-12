import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('theme');
    if (savedTheme == 'dark') {
      appTheme = ThemeMode.dark;
    } else {
      appTheme = ThemeMode.light;
    }
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async{
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', newTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }
  //or
  // bool get isDark =>appTheme ==ThemeMode.dark;
}
