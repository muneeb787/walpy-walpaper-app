import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:walpy_wallpapers/Screens/login_screen.dart';

import '../utils/toast.dart';

class SignUpProvider with ChangeNotifier {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  void performSignUp(BuildContext context, final formkey, final username,
      final email, final password) {
    if (formkey.currentState!.validate()) {
      loading = true;
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            auth.currentUser?.updateDisplayName(username);
        loading = false;
        Navigator.pushNamed(context, LoginScreen.pageName);
      }).onError((error, stackTrace) {
        Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
        loading = false;
        notifyListeners();
      });
    }
  }
}
