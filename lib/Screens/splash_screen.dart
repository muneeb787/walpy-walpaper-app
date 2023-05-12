import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Providers/splash_screen_provider.dart';
import 'package:walpy_wallpapers/Screens/intro_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SplashProvider>(context);
    provider.checkLogin(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/bg-1.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(41, 51, 62, 0.6),
                borderRadius: BorderRadius.circular(72)),
            child: const Padding(
              padding: EdgeInsets.all(40.0),
              child: Image(
                image: AssetImage('assets/images/log-icon.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
