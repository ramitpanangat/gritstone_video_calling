import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/palletes.dart';
import '../constants/route_constants.dart';

class FirebaseServices {
  FirebaseAuth? _firebaseAuth;

  FirebaseServices() {
    initValues();
  }

  initValues() async {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User? get userDetails => _firebaseAuth!.currentUser;

  Future createAccount(String fullName, String email, String password) async {
    try {
      var res = await _firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
      await res.user!.updateDisplayName(fullName);
      return res.user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future login(String email, String password) async {
    try {
      await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      return e;
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        var res = await FirebaseAuth.instance.signInWithCredential(credential);
        return res.user;
      } else {
        return googleUser;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      return e;
    }
  }

  Future<bool> checkAuthentication() async {
    User? user = await _firebaseAuth!.authStateChanges().first;
    return user != null;
  }

  Future logout(BuildContext context) async {
    await _firebaseAuth!.signOut();
    await GoogleSignIn().signOut();
    if (context.mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
      context.pushReplacementNamed(RouteNames.root);
    }
  }

  handleErrors(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        showCloseIcon: true,
        content: Text(
          message ?? 'Something went wrong',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
        backgroundColor: kPrimaryColor));
  }
}
