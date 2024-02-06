import 'package:booktopia/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:booktopia/notificationservice/local_notification_service.dart';
import 'package:booktopia/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'login/login.dart';
import 'login/splash.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized(); //upore same line acce dorkar ki
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize;

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
