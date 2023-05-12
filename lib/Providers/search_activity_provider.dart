import 'package:flutter/material.dart';

class SearchActivityProvider with ChangeNotifier {
  String searchTitle = 'random';

  void setSearchTitle(String element) {
    searchTitle = element;
    notifyListeners();
  }
}
