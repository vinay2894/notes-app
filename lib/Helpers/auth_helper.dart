import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignInAccount? googleUser;

  Future<User?> SignUpEmailPassword({
    required String email,
    required String password,
  }) async {
    UserCredential? credential;
    try {
      credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Week Password') {
        log('your password is week');
      } else if (e.code == 'email already in use') {
        log('Email is already exists');
      } else {
        log("$e");
      }
    }
    if (credential != null) {
      log("Credential is Come...");
      return credential.user;
    } else {
      log("Data is Null...");
      return null;
    }
  }

  Future<User?> SignInWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential? credential;
    try {
      credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
    if (credential != null) {
      return credential.user;
    } else {
      return null;
    }
  }

  Future<User?> getUserWithCredential() async {
    googleUser = await GoogleSignIn(scopes: ['email']).signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential? userCredential;
    userCredential = await firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
}
