import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/routes/routes.dart';
import 'package:untitled2/views/screens/Home_Page.dart';
import 'package:untitled2/views/screens/SignUp_Page.dart';
import 'package:untitled2/views/screens/add_notes.dart';
import 'package:untitled2/views/screens/sign_in_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        routes: {
          MyRoutes.sign_in_page: (context) => SignIn(),
          MyRoutes.Home_Page: (context) => HomePage(),
          MyRoutes.signup: (context) => Sign_Up(),
          MyRoutes.add_notes: (context) => Addnotes(),
        });
  }
}
