import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<User?> signIngAnonymousely() async {
    final credentials = await _firebaseAuth.signInAnonymously();
    return credentials.user;
  }

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final credentials = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return credentials.user;
      }
      else {
        throw FirebaseAuthException(message: 'Invalid credentials', code: 'invalid');
      }
    } else {
      throw FirebaseAuthException(
          message: 'Sign In aborted by user', code: 'aborted');
    }
  }

   Future<String> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      String _message;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          _message = 'Unable to log you in\nPlease try again';
          break;
        case 'user-disabled':
          _message = 'This user has been disabled';
          break;
        default:
          _message = 'Unable to connect\nPlease check your internet connection';
      }
      return _message;
    }
  }

  Future<String> signUpWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      String _message;
      switch (e.code) {
        case 'email-already-in-use':
          _message =
              'This email is alredy in use\nPlease try again with a different email';
          break;
        case 'invalid-email':
          _message =
              'This email is not valid\nPlease try again with a valid email';
          break;
        case 'weak-password':
          _message =
              'This password is too weak\nPlease try again with a stronger password';
          break;
        default:
          _message = 'Unable to connect\nPlease check your internet connection';
      }
      return _message;
    }
  }

  Future<void> signOut() async {
    final google = GoogleSignIn();
    await google.signOut();
    await _firebaseAuth.signOut();
  }
}
