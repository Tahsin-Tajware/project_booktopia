import 'package:booktopia/auth.dart';
import 'package:flutter/material.dart';
import 'package:booktopia/google.dart';
import 'package:animated_switch/animated_switch.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Mylogin());
}

class Mylogin extends StatefulWidget {
  const Mylogin({super.key});

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  bool _isTextVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isTextVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sign.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 70),
                  child: Text(
                    'BOOKTOPIA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SF'),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    AnimatedOpacity(
                      opacity: _isTextVisible ? 1.0 : 1.0,
                      duration: Duration(milliseconds: 1500),
                      child: AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 1700),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _isTextVisible ? 17.5 : 0.0,
                          fontWeight: FontWeight.w900,
                        ),
                        child: Text(
                          '" Discover books online. Welcome to you. "',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'S',
                            ),
                          ),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(250, 70)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.cyanAccent),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25), // Add spacing between buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'signup');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'S',
                            ),
                          ),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(250, 70)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlue),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                            onTap: () {
                              //Navigator.pushNamed(context, 'home');
                            },
                            imagePath: 'assets/otp.png'),
                        SizedBox(width: 30),
                        SquareTile(
                            onTap: () =>
                                AuthService().signInWithGoogle(context),
                            imagePath: 'assets/google.png'),
                        SizedBox(width: 30),
                        SquareTile(onTap: () {}, imagePath: 'assets/apple.png'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
