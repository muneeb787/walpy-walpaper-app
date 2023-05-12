import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/main_activity_screen.dart';
import 'package:walpy_wallpapers/utils/toast.dart';

class LoginProvider with ChangeNotifier {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  void performLogin(
      BuildContext context, final formkey, final email, final password) {
    if (formkey.currentState!.validate()) {
      loading = true;
      debugPrint(email);
      debugPrint(password);

      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        loading = false;
        notifyListeners();
        Utils().toastMessage(
            errorMsg: 'Sign In Successfully', bgColor: Colors.green);
        Navigator.pushReplacementNamed(context, MainActivity.pageName);
      }).onError((error, stackTrace) {
        loading = false;
        notifyListeners();
        Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
      });
    }
  }

  void performSignUp(BuildContext context, final formkey, final username,
      final email, final password) {
    if (formkey.currentState!.validate()) {
      loading = true;
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        loading = false;
      }).onError((error, stackTrace) {
        Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
        loading = false;
        notifyListeners();
      });
    }
  }
}
