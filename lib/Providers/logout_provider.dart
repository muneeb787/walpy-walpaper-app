import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/select_auth_screen.dart';

class LogoutProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  void logoutUser(BuildContext context) {
    debugPrint('LoggingOut');
    auth.signOut();
    notifyListeners();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, SelectAuthentication.pageName);
  }
}
