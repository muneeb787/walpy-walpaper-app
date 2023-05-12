import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Screens/signup_screen.dart';
import '../Providers/google_signin_provider.dart';

import 'login_screen.dart';

class SelectAuthentication extends StatelessWidget {
  const SelectAuthentication({Key? key}) : super(key: key);
  static const pageName = '/selectauth';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleLogin>(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg-2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
                stops: const [0.0, 0.9],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/Logo.png'),
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Only Wallpaper app you will ever need ...!',
                      style: Theme.of(context).textTheme.displaySmall),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.pageName);
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up with Email',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.loginWithGoogle(context);
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Image(
                                image: AssetImage('assets/icons/glogo.png'),
                              ),
                              Text(
                                'Continue With Google',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have an Account?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.pageName);
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
