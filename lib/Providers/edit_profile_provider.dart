import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/profile_screen.dart';
import 'package:walpy_wallpapers/utils/toast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider with ChangeNotifier {
  File? image;
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  //final storage = FirebaseStorage.instance;
  String photoUrl = '';
  //File? image;

  Future<void> setProfileData(
      BuildContext context, final name, final number) async {
    loading = true;
    try {
      final user = auth.currentUser;
      await user?.updateDisplayName(name).then((value) async {
        if(image != null){
          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
              .ref('users/${auth.currentUser?.uid}/profile_picture.png');
          firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);

          await Future.value(uploadTask);
          var newUrl = await ref.getDownloadURL();

          final userData = auth.currentUser;
          userData?.updatePhotoURL(newUrl);
          notifyListeners();
        }
      });
      Utils().toastMessage(
          errorMsg: "Data Update Successfully", bgColor: Colors.green);
      Navigator.pop(context,true);
      loading = false;
    } catch (e) {
      Utils().toastMessage(errorMsg: e.toString(), bgColor: Colors.red);
      loading = false;
    }
  }

  Future<void> updateProfile(String photoURL) async {
    final user = auth.currentUser;
    user?.updatePhotoURL(photoURL);
  }

  // Future<File> selectProfileImage() async {
  //   final picker = ImagePicker();
  //
  //   final pickedFile = await picker
  //       .pickImage(source: ImageSource.gallery)
  //       .onError((error, stackTrace) {
  //     Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
  //   });
  //
  //   File file = File(pickedFile!.path);
  //   notifyListeners();
  //   return file;
  // }
  //


  Future<void> getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print(pickedFile.path);
        image = File(pickedFile.path);
      }
      notifyListeners();
  }


  // Future<void> uploadImageAndSaveUrl() async {
  //   final picker = ImagePicker();
  //
  //   final pickedFile = await picker
  //       .pickImage(source: ImageSource.gallery)
  //       .onError((error, stackTrace) {
  //     Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
  //   });
  //
  //   if (pickedFile == null) return;
  //
  //   final file = File(pickedFile.path);
  //
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //       .ref('users/${auth.currentUser?.uid}/profile_picture.png');
  //   firebase_storage.UploadTask uploadTask = ref.putFile(file.absolute);
  //
  //   await Future.value(uploadTask);
  //   var newUrl = await ref.getDownloadURL();
  //
  //   // final snapshot = await storage
  //   //     .ref('users/${auth.currentUser?.uid}/profile_picture.png')
  //   //     .putFile(file)
  //   //     .whenComplete(() {
  //   //       notifyListeners();
  //   //     })
  //   //     .then((value) => null)
  //   //     .onError((error, stackTrace) {
  //   //       Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
  //   //     });
  //
  //   // final downloadURL = await snapshot.ref
  //   //     .getDownloadURL()
  //   //     .then((value) {})
  //   //     .onError((error, stackTrace) {
  //   //   Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
  //   // });
  //   // photoUrl = downloadURL;
  //   updateProfile(newUrl.toString());
  // }
}
