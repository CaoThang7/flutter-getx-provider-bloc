import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  String text = "Done";
  Color color = Colors.red;

  void changeText() {
    if (text == "Done") {
      text = "Oke";
    } else {
      text = 'Done';
    }
    notifyListeners();
  }
}
