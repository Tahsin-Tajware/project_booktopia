import 'package:booktopia/homepage.dart';
import 'package:booktopia/signup.dart';
import 'package:booktopia/startpage.dart';
import 'package:flutter/material.dart';
import 'package:booktopia/homepage.dart';


import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'startpage',
    routes: {'startpage' :(context)=>Mylogin(),
      'login' :(context)=>MyLoginScreen(),
      'signup' :(context)=>SignupScreen(),
    'home' :(context)=>Homepage()},
  ));
}
