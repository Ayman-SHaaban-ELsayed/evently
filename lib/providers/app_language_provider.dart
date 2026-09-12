import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';
  AppLanguageProvider() {
    _loadLanguage();
  }
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }
  void changeLanguage(String newLanguage) async{
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);}
}
