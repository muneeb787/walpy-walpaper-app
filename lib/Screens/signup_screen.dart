import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Providers/signUp_provider.dart';
import 'package:walpy_wallpapers/Screens/login_screen.dart';
import 'package:walpy_wallpapers/Screens/select_auth_screen.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';

import '../Providers/google_signin_provider.dart';
import '../Widgets/functional_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static const pageName = '/signup';

  final _formKey = GlobalKey();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    final gprovider = Provider.of<GoogleLogin>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navButton(
                    const Icon(Icons.arrow_back_ios),
                    () => Navigator.pushReplacementNamed(
                        context, SelectAuthentication.pageName),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Getting Started',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Welcome back, You’ve been missed',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
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
                              hintText: 'Enter Your Username',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
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
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
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
                            suffixIcon: Icon(Icons.private_connectivity),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            hintText: 'Enter Your Password',
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
                        TextFormField(
                          controller: cPasswordController,
                          obscureText: true,
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
                            suffixIcon: Icon(Icons.private_connectivity),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            hintText: 'Confirm Your Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm your Password';
                            } else if (value.toString() !=
                                passwordController.text.toString()) {
                              return 'Password must be Same';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  FunctionalButton(
                    title: 'Sign Up',
                    isload: provider.loading,
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      provider.performSignUp(
                          context,
                          _formKey,
                          usernameController.text.toString(),
                          emailController.text.toString(),
                          passwordController.text.toString());
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Text(
                    'Or Continue With Social Account',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      gprovider.loginWithGoogle(context);
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.9,
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
                            style: Theme.of(context).textTheme.displayMedium,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
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
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.pageName);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
