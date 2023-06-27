import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get authStatechange => _firebaseAuth.authStateChanges();
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error Occured"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              ));
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error Occured"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              ));
    } catch (e) {
      if (e == 'email already in used') {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Error Occured"),
                  content: Text("email already exist"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Error Occured"),
                  content: Text("Error:$e"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                ));
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
