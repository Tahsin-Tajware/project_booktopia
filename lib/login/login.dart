import 'package:booktopia/login/signup.dart';
import 'package:booktopia/view/main_tab/menubar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Forgotpass.dart';
import 'container_widget.dart';
import 'firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pro3.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Image.asset(
                  'assets/logo.png',
                  width: 180,
                  height: 180,
                ),
                SizedBox(height: 100),
                Text(
                  "Welcome to booktopia! Sign in to continue...",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Enter Email..........",
                  isPasswordField: false,

                ),
                SizedBox(
                  height: 15,
                ),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Enter Password..........",
                  isPasswordField: true,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Forgot_pass()));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () => _signIn(context),
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
        if (user != null) {
          print("Successfully signed in: ${user.email}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainTabView()),
          );
        } else {
          print("Sign in failed: User is null");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Incorrect email or password. Please try again.",
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    } catch (e) {
      print("Error during sign in: $e");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error during sign in. Please try again.",
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

}
