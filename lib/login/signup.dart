import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../view/main_tab/menubar.dart';
import 'container_widget.dart';
import 'firebase_auth_services.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _profileController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter a valid email and password.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.lightBlue.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FormContainerWidget(
                      controller: _nameController,
                      hintText: "Enter your name",
                      isPasswordField: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormContainerWidget(
                      controller: _emailController,
                      hintText: "Enter your email",
                      isPasswordField: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormContainerWidget(
                      controller: _passwordController,
                      hintText: "Enter password",
                      isPasswordField: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormContainerWidget(
                      //controller: _passwordController,
                      hintText: "Confirm password",
                      isPasswordField: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: _signUp,
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up to continue",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              color: Colors.lightBlue.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w900,
                                fontSize: 22),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     _signInWithGoogle();
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white24,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Center(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'assets/google.png',
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Text(
                    //             " Sign in with Google",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 20,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String profile = _profileController.text;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set({
        'name': name,
        'email': email,
        'address': '',
        'profile': profile,
      });

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set(
        {
          'email': email,
          'uid': userCredential.user!.uid,
        },
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainTabView()),
      );
    } catch (e) {
      print("Error signing up: $e");
    }
  }
}
//   _signInWithGoogle() async {
//     final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );
//
//         User? user = await _auth.signInWithGoogle(credential);
//
//         if (user != null) {
//           print("Successfully signed in with Google: ${user.email}");
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => MainTabView()));
//         } else {
//           print("Google Sign-In failed: User is null");
//           // Handle Google Sign-In failure if needed
//         }
//       }
//     } catch (e) {
//       print("Error during Google Sign-In: $e");
//       // Handle Google Sign-In error if needed
//     }
//   }
