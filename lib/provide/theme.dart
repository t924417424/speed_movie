import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class MyTheme extends ChangeNotifier{
  bool isDarkModeEnabled = false;
  bool get MyThemeMode => isDarkModeEnabled;
  void change_theme(bool isDarkModeEnabled){
    this.isDarkModeEnabled = isDarkModeEnabled;
    if(this.isDarkModeEnabled){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}