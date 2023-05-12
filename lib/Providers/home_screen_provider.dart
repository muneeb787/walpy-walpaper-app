import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier {
  int _currentIndex = 1;

  get currentIndex => _currentIndex;

  void incIndex() {
    _currentIndex++;
    notifyListeners();
  }

  void deccIndex() {
    _currentIndex--;
    notifyListeners();
  }
}
