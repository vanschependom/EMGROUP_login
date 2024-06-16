import 'package:flutter/material.dart';
import 'package:login_page/dashboard/dashboard.dart';
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
      themeMode: ThemeMode.system,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: LoginScreen(),
    );
  }
}
