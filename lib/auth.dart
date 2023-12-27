import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No Google user selected',
        );
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.pushNamed(context, 'home');
        return userCredential;
      }
    } catch (e) {
      print("Error signing in with Google: $e");

      // Show an error dialog to the user with specific error message
      String errorMessage = 'Failed to sign in with Google.';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An error occurred.';
        print("FirebaseAuthException: ${e.code} - ${e.message}");
        errorMessage = "Firebase Error: ${e.code}";
      } else {
        print("Unexpected Error: $e");
      }
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Authentication Failed'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return null;
  }
}
