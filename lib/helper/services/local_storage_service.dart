import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool?> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> checkData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('value');
    return CheckValue;
  }

  static start() async {
    if (checkData('logged_in') as bool == false)
      saveData('logged_in', false);
  }

  static Future<bool> checkLoggedIn() async {
    if (readBool('logged_in') as bool)
      return true;
    else
      return false;
  }

  static logIn() async {
    saveData('logged_in', true);
  }

  static logOut() async {
    saveData('logged_in', false);
  }
}
