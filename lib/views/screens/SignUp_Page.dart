import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Helpers/auth_helper.dart';
import '../../Helpers/firestore_helper.dart';
import '../../models/user_model.dart';
import '../../routes/routes.dart';

class Sign_Up extends StatelessWidget {
  Sign_Up({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: name,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Your Password";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Enter Your Password",
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      if (password.text == password.text) {
                        User? user = await AuthHelper.authHelper
                            .SignUpEmailPassword(
                                email: email.text, password: password.text);
                        UserModal usermodal = UserModal(
                          id: user!.uid,
                          name: name.text,
                          email: email.text,
                          password: password.text,
                        );
                        if (user != null) {
                          await FireStoreHelper.fireStoreHelper
                              .addUser(userModal: usermodal, uid: '');
                          Navigator.of(context)
                              .pushNamed(MyRoutes.sign_in_page)
                              .then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Successful"),
                                  ),
                                ),
                              );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("UnSuccessful"),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.brown),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
