import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'dart:io';

class Bank extends ChangeNotifier {
  Box<double> moneyBox = Hive.box<double>("Money");
  static String _name, _email, _city;
  static File image;
  static double _money = 0.0;

  Bank() {
    _money = moneyBox.get("balance", defaultValue: 0.0);
  }

  double getBalance() {
    return _money;
  }

  void addMoney(double amount) {
    _money += amount;
    moneyBox.put("balance", _money);
    notifyListeners();
  }

  void subMoney(double amount) {
    _money -= amount;
    moneyBox.put("balance", _money);
    notifyListeners();
  }

  void updateProfile(String name, String email, String city) {
    _name = name;
    _email = email;
    _city = city;
    notifyListeners();
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  String getCity() {
    return _city;
  }

  void setImage(File _image) {
    image = _image;
    notifyListeners();
  }

  File getImage() {
    return image;
  }
}
