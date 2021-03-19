import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex = 0;
  // int get count => _currentIndex;
  changeIndex(int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }
}