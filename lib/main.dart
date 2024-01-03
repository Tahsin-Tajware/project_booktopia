import 'package:booktopia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login/login.dart';
import 'login/splash.dart';
import '../../book_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTopia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Colors.black, // Set the background color to black
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(
        child: LoginPage(),
      ),
    );
  }
}
