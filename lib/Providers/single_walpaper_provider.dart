import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:walpy_wallpapers/utils/toast.dart';

import '../Services/api_services.dart';
import '../Widgets/nav_button.dart';

class SingleWallpaperProvider with ChangeNotifier {
  final firestore = FirebaseFirestore.instance.collection('favourites');
  final auth = FirebaseAuth.instance;
  bool isFavt = false;

  Future<bool> setWallpaper(
      BuildContext context, int location, String url) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(url);

      final result = await WallpaperManager.setWallpaperFromFile(
        file.path,
        location,
      );
      // Dismiss the dialog
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(37.0),
              ),
              child: Container(
                  height: 380,
                  width: 330,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          navButton(
                            const Icon(
                              Icons.close,
                            ),
                            () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const Image(
                        image: AssetImage('assets/images/hurray.png'),
                      ),
                      Text(
                        'Wallpaper Set Successfully',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(37),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: const Center(
                            child: Text('Back To Home'),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      );

      return true;
    } on PlatformException {
      // Show error message using a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to set wallpaper'),
        ),
      );
      return false;
    }
  }

  void showBottomSheet(BuildContext context, String wallpaperUrl) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () async {
                  await setWallpaper(
                      context, WallpaperManager.HOME_SCREEN, wallpaperUrl);
                },
                child: const Text('Set Wallpaper on Home Screen'),
              ),
              TextButton(
                onPressed: () async {
                  await setWallpaper(
                      context, WallpaperManager.LOCK_SCREEN, wallpaperUrl);
                },
                child: const Text('Set Wallpaper on Lock Screen'),
              ),
              TextButton(
                onPressed: () async {
                  await setWallpaper(
                      context, WallpaperManager.BOTH_SCREEN, wallpaperUrl);
                },
                child: const Text('Set Wallpaper on Both'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> makeFavourite(
      BuildContext context, String wallpaperUrl, String wallpaperId) async {
    final user = auth.currentUser;

    if (isFavt) {
      try {
        final userDoc = firestore.doc(user!.uid);
        userDoc.get().then((snapshot) async {
          notifyListeners();
          if (snapshot.exists) {
            await userDoc.update({
              'favorites': FieldValue.arrayRemove([wallpaperId])
            });
          } else {}
        }).onError((error, stackTrace) {});

        Utils().toastMessage(errorMsg: 'UnFavourite', bgColor: Colors.green);
      } catch (error) {
        Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
      }
    } else {
      try {
        final userDoc = firestore.doc(user!.uid);
        userDoc.get().then((snapshot) async {
          if (snapshot.exists) {
            await userDoc.update({
              'favorites': FieldValue.arrayUnion([wallpaperId])
            });
          } else {
            userDoc.set({
              'favorites': FieldValue.arrayUnion([wallpaperId])
            });
          }
        }).onError((error, stackTrace) {});

        Utils().toastMessage(errorMsg: 'Favourite', bgColor: Colors.green);
      } catch (error) {
        Utils().toastMessage(errorMsg: error.toString(), bgColor: Colors.red);
      }
    }
  }

  Future<void> checkFavorite(String walpId) async {
    final uid = auth.currentUser?.uid;
    await ApiServices()
        .getArrayFromFirestore('favourites/$uid', 'favorites')
        .then((value) {
      if (value.contains(walpId)) {
        isFavt = true;
        notifyListeners();
      } else {
        isFavt = false;
        notifyListeners();
      }
    });
  }
}
