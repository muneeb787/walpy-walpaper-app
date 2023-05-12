import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';

import '../Providers/edit_profile_provider.dart';
import '../Widgets/functional_button.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  static const pageName = '/editprofile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey();

  final displayName = TextEditingController();
  final displayemail = TextEditingController();
  final phNumber = TextEditingController();

  File? image;
  String photoURL = '';
  bool check = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    final user = auth.currentUser;

    displayName.text = '${user?.displayName}';
    displayemail.text = '${user?.email}';
    phNumber.text = '${user?.phoneNumber}';
    photoURL = '${user?.photoURL}';
    print(photoURL);
    if (photoURL != null) {
      check = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileProvider>(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Image(
                  image: AssetImage('assets/images/profile_page_bg.png'),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: navButton(
                    const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    () => Navigator.pop(context),
                  ),
                ),
                Positioned.fill(
                  bottom: -60,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 150,
                      height: 150,
                      child: GestureDetector(
                        onTap: provider.getImage,
                        child: provider.image == null
                            ? CircleAvatar(
                          radius: 50.0,
                          child: Icon(
                            Icons.camera_alt,
                            size: 40.0,
                          ),
                        )
                            : CircleAvatar(
                          radius: 50.0,
                          backgroundImage: FileImage(provider.image!),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: displayName,
                      onChanged: (value) {
                        displayName.selection = TextSelection.fromPosition(
                            TextPosition(offset: displayName.text.length));
                      },
                      onTap: () {
                        displayName.selection = TextSelection.fromPosition(
                            TextPosition(offset: displayName.text.length));
                      },
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                          fillColor: Color(0xFF3d424c),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          hintText: 'Enter Your Name',
                          prefixIcon: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // TextFormField(
                    //   controller: phNumber,
                    //   cursorColor: Colors.white,
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 16,
                    //   ),
                    //   decoration: const InputDecoration(
                    //       fillColor: Color(0xFF3d424c),
                    //       filled: true,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(15.0),
                    //         ),
                    //       ),
                    //       hintText: 'Enter Your Phone Number',
                    //       prefixIcon: Icon(
                    //         Icons.phone,
                    //         color: Colors.white,
                    //       ),
                    //       hintStyle: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 14,
                    //       )),
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    TextFormField(
                      enabled: false,
                      controller: displayemail,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        fillColor: Color(0xFF3d424c),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FunctionalButton(
                        isload: provider.loading,
                        title: 'Update',
                        onPress: () {
                          FocusScope.of(context).unfocus();
                          provider.setProfileData(
                              context,
                              displayName.text.toString(),
                              phNumber.text.toString());
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
