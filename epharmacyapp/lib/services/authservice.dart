import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/firebaseconstants.dart';
import '../core/failure.dart';
import '../core/type_def.dart';
import '../models/usermodel.dart';
import '../providers/firebaseproviders.dart';

final authServiceProvider = Provider((ref) => AuthService(
    firestore: ref.read(FirebaseFirestoreProvider),
    firebaseAuth: ref.read(FirebaseAuthProvider),
    firebaseStorage: ref.read(firebaseStorageProvider)));

class AuthService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  AuthService(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth,
      required FirebaseStorage firebaseStorage})
      : _firestore = firestore,
        _firebaseAuth = firebaseAuth,
        _firebaseStorage = firebaseStorage;
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  late UserModel _userModel;

  FutureEither<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(UserModel(uid: _firebaseAuth.currentUser!.uid));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  // FutureEither<UserModel> signUpWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     _firebaseAuth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then((userCredential) async {
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         _userModel = UserModel(uid: _firebaseAuth.currentUser!.uid);
  //         await _users
  //             .doc(_firebaseAuth.currentUser!.uid)
  //             .set(_userModel.toMap());
  //       } else {
  //         _userModel = await getUserData(userCredential.user!.uid).first;
  //       }
  //     });

  //     return right(UserModel(uid: _firebaseAuth.currentUser!.uid));
  //   } catch (e) {
  //     return left(Failure(message: e.toString()));
  //   }
  // }
  FutureEither<UserModel> signUpWithEmailAndPassword(String email, String password) async {
  try {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    if (userCredential.additionalUserInfo!.isNewUser) {
      _userModel = UserModel(uid: userCredential.user!.uid);
      await _users.doc(userCredential.user!.uid).set(_userModel.toMap());
    } else {
      _userModel = await getUserData(userCredential.user!.uid).first;
    }

    return right(_userModel);
  } catch (e) {
    return left(Failure(message: e.toString()));
  }
}


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<UserModel> getUserData(uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
