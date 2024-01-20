import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lang {
  static const pref = "pref_key";

  setLang(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(pref, value);
  }

  getLang() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(pref) ?? false;
  }
}

class LangProvider extends ChangeNotifier {
  bool? _isEn;

  bool get isEn => _isEn!;

  Lang? _preferences;

  LangProvider() {
    _isEn = false;
    _preferences = Lang();
    getPreferences();
  }

  set isEn(bool value) {
    _isEn = value;
    _preferences!.setLang(value);
    notifyListeners();
  }

  getPreferences() async {
    _isEn = await _preferences!.getLang();
    notifyListeners();
  }
}

//Switching themes in the flutter apps - Flutterant
