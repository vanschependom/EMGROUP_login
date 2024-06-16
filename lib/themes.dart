import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      // gemeenschappelijke theme data tussen light en dark mode
      // hier komen bijvoorbeeld de styles voor de fonts
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: GoogleFonts.interTightTextTheme(
        const TextTheme(
            // hier komen adjustmenst aan de standaard styling
            headlineLarge:
                TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300)),
      ),
    );
  }

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  // kleuren komen altijd voor in paren
  //  - de gewone kleur (primary, secondary, surface, ...)
  //  - de kleur die gebruikt wordt voor de tekst op die kleur (onPrimary, onSecondary, onSurface, ...)

  static const ColorScheme lightColorScheme = ColorScheme(
    // theme data enkel voor light mode
    // verder aan te vullen
    primary: Color(0xffa02b2b),
    onPrimary: Colors.white,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color.fromARGB(255, 66, 41, 41),
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Color.fromARGB(255, 236, 236, 236),
    onSurface: Color.fromARGB(255, 48, 30, 30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    // theme data enkel voor dark mode
    // verder aan te vullen
    primary: Color(0xffa02b2b),
    secondary: Color.fromARGB(255, 124, 31, 31),
    surface: Color.fromARGB(255, 37, 20, 20),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
