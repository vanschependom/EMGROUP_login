import 'package:flutter/material.dart';
import 'package:login_page/login/loginpage.dart';
import 'package:login_page/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MyTimeThemes.lightMode,
        darkTheme: MyTimeThemes.darkMode,
        home: const LoginScreen());
  }
}
