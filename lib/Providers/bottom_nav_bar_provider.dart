import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/home_screen.dart';
import 'package:walpy_wallpapers/Screens/select_auth_screen.dart';

import '../Screens/category_list_screen.dart';
import '../Screens/search_screen.dart';
import '../Screens/setting_screen.dart';

class BottomNavBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  FirebaseAuth auth = FirebaseAuth.instance;
  void checkLogin(BuildContext context) {
    final user = auth.currentUser;
    if (user == null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SelectAuthentication(),
          ),
        );
      });
    }
  }

  List<Widget> pages = [
    const HomePage(),
    const CategoryScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];

  void changeCurrentIndex(newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
