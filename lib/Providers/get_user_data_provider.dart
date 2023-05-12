import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/edit_profile.dart';

class GetProfileProvider with ChangeNotifier {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  String dispalyName() {
    final user = auth.currentUser;
    String? name = user?.displayName;
    name ??= 'Not Set Yet';
    return name;
  }

  String number() {
    final user = auth.currentUser;
    String? number = user?.phoneNumber;
    number ??= 'Not Set Yet';
    return number;
  }

  String email() {
    final user = auth.currentUser;
    String? email = user?.email;
    email ??= 'Not Set Yet';
    return email;
  }

  String photoUrl() {
    final user = auth.currentUser;
    String? url = user?.photoURL;
    url ??= 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
    return url;
  }

  Future<void> getUpdated(BuildContext context) async {
    bool refresh = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return EditProfileScreen();
    }));
    if(refresh == true){
      notifyListeners();
    }
  }

}
