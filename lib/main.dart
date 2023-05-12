import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Providers/google_signin_provider.dart';
import 'package:walpy_wallpapers/Providers/home_screen_provider.dart';
import 'package:walpy_wallpapers/Providers/logout_provider.dart';
import 'package:walpy_wallpapers/Providers/search_activity_provider.dart';
import 'package:walpy_wallpapers/Providers/single_walpaper_provider.dart';
import 'package:walpy_wallpapers/Providers/splash_screen_provider.dart';
import 'package:walpy_wallpapers/Screens/favourite_screen.dart';
import 'package:walpy_wallpapers/Screens/intro_screen.dart';
import 'package:walpy_wallpapers/Screens/login_screen.dart';
import 'package:walpy_wallpapers/Screens/main_activity_screen.dart';
import 'package:walpy_wallpapers/Screens/profile_screen.dart';
import 'package:walpy_wallpapers/Screens/search_screen.dart';
import 'package:walpy_wallpapers/Screens/select_auth_screen.dart';
import 'package:walpy_wallpapers/Screens/setting_screen.dart';
import 'package:walpy_wallpapers/Screens/signup_screen.dart';
import 'Providers/bottom_nav_bar_provider.dart';
import 'Providers/category_list_provider.dart';
import 'Providers/edit_profile_provider.dart';
import 'Providers/get_user_data_provider.dart';
import 'Providers/intro_screen_provider.dart';
import 'Providers/login_provider.dart';
import 'Providers/signUp_provider.dart';
import 'Screens/edit_profile.dart';
import 'Screens/priacy_policy_screen.dart';
import 'Screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  runApp(const Walpy());
}

class Walpy extends StatelessWidget {
  const Walpy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IntroScreenProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => CategoryPhotoProvider()),
        ChangeNotifierProvider(create: (context) => SingleWallpaperProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => GoogleLogin()),
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => GetProfileProvider()),
        ChangeNotifierProvider(create: (context) => LogoutProvider()),
        ChangeNotifierProvider(create: (context) => SearchActivityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(18, 25, 40, 1.0),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: const Color.fromRGBO(142, 105, 247, 1.0)),
          textTheme: const TextTheme(
            bodySmall: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
            bodyLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
                color: Colors.white),
            displaySmall: TextStyle(fontSize: 8, color: Colors.white),
            displayMedium: TextStyle(fontSize: 14, color: Colors.white),
            displayLarge: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        //home: const SplashScreen(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const SplashScreen(),
          IntroScreen.pageName: (context) => const IntroScreen(),
          MainActivity.pageName: (context) => const MainActivity(),
          SettingsScreen.pageName: (context) => const SettingsScreen(),
          PrivacyPolicyScreen.pageName: (context) =>
              const PrivacyPolicyScreen(),
          LoginScreen.pageName: (context) => LoginScreen(),
          SignUpScreen.pageName: (context) => SignUpScreen(),
          EditProfileScreen.pageName: (context) => EditProfileScreen(),
          ProfileScreen.pageName: (context) => const ProfileScreen(),
          FavouriteScreen.pageName: (context) => FavouriteScreen(),
          SearchScreen.pageName: (context) => SearchScreen(),
          SelectAuthentication.pageName: (context) =>
              const SelectAuthentication(),
        },
      ),
    );
  }
}
