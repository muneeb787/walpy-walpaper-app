import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walpy_wallpapers/Screens/main_activity_screen.dart';

import '../Screens/intro_screen.dart';
import '../Widgets/nav_button.dart';

class SplashProvider with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  void checkLogin(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      print('no internet connection');
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
                        'No Internet Connected',
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
    }else{
      final user = auth.currentUser;
      final displayName = 'John Doe';

      await user?.updateDisplayName(displayName);
      debugPrint('user is : $user');
      if (user != null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainActivity(),
            ),
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const IntroScreen(),
            ),
          );
        });
      }
    }

  }
}
