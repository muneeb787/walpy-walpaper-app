import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/main_activity_screen.dart';
import 'package:walpy_wallpapers/utils/toast.dart';

class GoogleLogin with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  void loginWithGoogle(BuildContext context) {
    auth.signInWithProvider(GoogleAuthProvider()).then((value) {
      Navigator.pushReplacementNamed(context, MainActivity.pageName);
      Utils()
          .toastMessage(errorMsg: 'SignIn Succesfully', bgColor: Colors.green);
    }).onError((error, stackTrace) {
      Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
    });
  }
}
