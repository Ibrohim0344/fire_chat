import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

abstract class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user from FirebaseUser
  static UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            username: user.displayName,
          )
        : null;
  }

  //sign in anonymous
  static Future<UserModel?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  //auth change user stream
  static Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sing in with email and password
  static Future<UserModel?> signInWithEmailAndPassword(
    String password,
    String email,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static User? get currentUser => _auth.currentUser;

  //register with email
  static Future<UserModel?> registerWithEmailAndPassword(
    String password,
    String email,
    String username,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(username);
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null) return null;
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //sign out
  static Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// static Stream getAllUsers() {}
}
