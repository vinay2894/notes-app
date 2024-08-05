import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Helpers/auth_helper.dart';
import '../../routes/routes.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(15),
            Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    "Login Page",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(15),
                  TextFormField(
                    controller: email,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your email";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      labelText: "Enter your email..",
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Gap(15),
                  TextFormField(
                    controller: password,
                    validator: (val) {
                      if (val!.isEmpty) {
                        print('Enter your password');
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                      ),
                      labelText: "Enter your Password..",
                      hintText: "Passwords",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Gap(25),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          "Sign In ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        User? user =
                            await AuthHelper.authHelper.SignInWithEmailPassword(
                          email: email.text,
                          password: password.text,
                        );
                        if (user != null) {
                          Navigator.of(context).pushNamed(
                            MyRoutes.Home_Page,
                            arguments: user,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Not done!!!"),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  Gap(30),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(MyRoutes.signup);
                        },
                        child: Text("Sign Up"),
                      ),
                    ],
                  ),
                  Gap(
                    50,
                  ),
                  Text(
                    "--------------------OR--------------------",
                  ),
                  Gap(
                    50,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      FirebaseAuth firebaseauth = FirebaseAuth.instance;
                      GoogleSignIn googleSignIn = GoogleSignIn(
                        scopes: ['email'],
                      );

                      GoogleSignInAccount? account =
                          await googleSignIn.signIn();
                      GoogleSignInAuthentication authentication =
                          await account!.authentication;

                      firebaseauth
                          .signInWithCredential(
                        GoogleAuthProvider.credential(
                          idToken: authentication.idToken,
                          accessToken: authentication.accessToken,
                        ),
                      )
                          .then(
                        (value) {
                          log('successful');
                          return Navigator.pushReplacementNamed(
                              context, 'home_page');
                        },
                      ).onError((error, stackTrace) {
                        Text("error");
                      });
                    },
                    icon: Icon(Icons.g_mobiledata),
                    label: Text("Login with google"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
