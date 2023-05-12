import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpy_wallpapers/Screens/select_auth_screen.dart';
import 'package:walpy_wallpapers/Screens/signup_screen.dart';
import 'package:walpy_wallpapers/Widgets/nav_button.dart';

import '../Providers/google_signin_provider.dart';
import '../Providers/login_provider.dart';
import '../Widgets/functional_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const pageName = '/login';

  final _formKey = GlobalKey();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    final gprovider = Provider.of<GoogleLogin>(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
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
                  Text(
                    'Let\'s Sign You In',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Welcome back, You’ve been missed',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
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
                          keyboardType: TextInputType.emailAddress,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forget Your Password ?',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  FunctionalButton(
                      isload: provider.loading,
                      title: 'Sign In',
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        provider.performLogin(
                            context,
                            _formKey,
                            emailController.text.toString(),
                            passwordController.text.toString());
                      })
                ],
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
                  const SizedBox(
                    height: 10,
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
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t Have any Account ?',
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
                              context, SignUpScreen.pageName);
                        },
                        child: Text(
                          'Sign Up',
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
