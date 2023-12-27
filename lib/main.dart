import 'package:booktopia/signup.dart';
import 'package:booktopia/startpage.dart';
import 'package:booktopia/view/main_tab/main_tab_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'common/color_extension.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: TColor.primary,
      fontFamily: 'SF Pro Text',
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: 'startpage',
    routes: {
      'startpage': (context) => Mylogin(),
      'login': (context) => MyLoginScreen(),
      'signup': (context) => SignupScreen(),
      'home': (context) => MainTabView(),
    },
    home: const MainTabView(),
  ));
}
