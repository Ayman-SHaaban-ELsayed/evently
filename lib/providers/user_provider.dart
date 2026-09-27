import 'package:final_project/model/my_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  UserProvider();

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('user_id');
    final String? name = prefs.getString('user_name');
    final String? email = prefs.getString('user_email');
    print("dataAyman  $id /  $name $email");
    if (id != null && name != null && email != null) {
      currentUser = MyUser(id: id, name: name, email: email);
      notifyListeners();
    }
  }

  void updateUser(MyUser newUser) async {
    currentUser = newUser;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', newUser.id);
    await prefs.setString('user_name', newUser.name);
    await prefs.setString('user_email', newUser.email);
  }

  void clearUser() async {
    currentUser = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }
}
