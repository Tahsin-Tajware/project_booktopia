import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // String uid = credential.user!.uid;
      // await _firestore.collection("users").doc(uid).set({
      //   'email': email,
      //   'uid': uid,
      //   'name': "", // Add more fields as needed
      //   'address': "", // Add more fields as needed
      //   'profile': "", // Add more fields as needed
      // });
      await _firestore.collection("Users").doc(credential.user!.uid).set(
        {
          'email': email,
          'uid': credential.user!.uid,
        },
      );
      return credential.user;
    } catch (e) {
      print("Some error occurred");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // await _firestore.collection("users").doc(credential.user!.uid).set(
      //   {
      //     'email': email,
      //     'uid': credential.user!.uid,
      //   },
      // );
      return credential.user;
    } catch (e) {
      print("Some error occurred");
    }
    return null;
  }

  Future<User?> signInWithGoogle(AuthCredential credential) async {
    try {
      UserCredential authResult = await _auth.signInWithCredential(credential);
      return authResult.user;
    } catch (e) {
      print("Some error occurred $e");
    }
    return null;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
