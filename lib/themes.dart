import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTimeThemes {
  static const Color primaryColor = Color(0xFF6C1313);
  static const Color inversePrimary = Colors.white;

  // light mode colors
  static ThemeData lightMode = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme:
          ColorScheme.fromSeed(seedColor: Colors.grey, primary: primaryColor),
      textTheme: GoogleFonts.interTightTextTheme(
        const TextTheme(
            // hier komen adjustmenst aan de standaard styling
            headlineLarge:
                TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      extensions: const <ThemeExtension<CustomColors>>{
        CustomColors(infoColor: Colors.grey)
      });

  // dark mode colors
  static final ThemeData darkMode = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all(primaryColor),
      //       foregroundColor: MaterialStateProperty.all(inversePrimary)),
      // ),
      extensions: const <ThemeExtension<CustomColors>>{
        CustomColors(infoColor: Colors.grey)
      });
}

class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({required this.infoColor});

  final Color? infoColor;

  @override
  CustomColors copyWith({Color? customColor}) {
    return CustomColors(infoColor: customColor ?? this.infoColor);
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(infoColor: Color.lerp(infoColor, other.infoColor, t));
  }
}
