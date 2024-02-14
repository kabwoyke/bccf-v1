import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{

  bool isLoading = false;

  void loading(){
    isLoading = true;
    notifyListeners();
  }

  void notLoading(){
    isLoading = false;
    notifyListeners();
  }
}