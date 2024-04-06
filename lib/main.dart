import 'package:flutter/material.dart';
import 'package:login_signup/dashboard.dart';
import 'package:login_signup/routes/registration.dart';
import 'package:login_signup/routes/signup.dart';
import 'package:login_signup/splashscreen.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login_Signup",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: MySplashScreen(),
    );
  }
}

void main() {
  runApp(const MainApp());
}
