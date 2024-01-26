
import 'package:booktopia/firebase_options.dart';
import 'package:booktopia/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'login/login.dart';
import 'login/splash.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTopia',


      theme: Provider.of<ThemeProvider>(context).themeData,

      // ThemeData(
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     background: Colors.grey.shade200,
      //   ),
      //   useMaterial3: true,
      // ),
      home: SafeArea(
        bottom: true,
        child: SplashScreen(
          child: LoginPage(),
        ),
      ),
    );
  }
}
