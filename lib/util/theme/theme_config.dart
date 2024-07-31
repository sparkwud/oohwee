import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oohwee/util/theme/pallete.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // backgroundColor: lightBG,
    primaryColor: Pallete.lightPrimary,
    scaffoldBackgroundColor: Pallete.lightBG,
    appBarTheme: const AppBarTheme(elevation: 0),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // backgroundColor: darkBG,
    primaryColor: Pallete.darkPrimary,
    scaffoldBackgroundColor: Pallete.darkBG,
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
    ),
  );

  static BoxShadow cardShadow = BoxShadow(
    color: Colors.grey[300]!.withOpacity(0.8),
    blurRadius: 8.0,
    spreadRadius: 0.0,
    offset: const Offset(0.0, 2.0),
  );
}

class RickAndMortyTheme {
  // static const Color _primaryLight = Color(0xFF97CE4C);
  static const Color _primaryLight = Color(0xFF60a85f);

  static const Color _secondaryLight = Color(0xFF00B5CC);
  static const Color _backgroundLight = Color(0xFFF0F0F0);
  static const Color _surfaceLight = Colors.white;
  static const Color _textLight = Color(0xFF35596C);

  static const Color _primaryDark = Color(0xFF44281D);
  static const Color _secondaryDark = Color(0xFFE4A788);
  static const Color _backgroundDark = Color(0xFF3C3E44);
  static const Color _surfaceDark = Color(0xFF24282F);
  static const Color _textDark = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: _primaryLight,
      secondary: _secondaryLight,
      surface: _surfaceLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _textLight,
    ),
    scaffoldBackgroundColor: _backgroundLight,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: _textLight, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: _textLight),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: _surfaceLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryLight,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: _primaryLight),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: _primaryDark,
      secondary: _secondaryDark,
      surface: _surfaceDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _textDark,
      // onPrimaryContainer:
    ),
    scaffoldBackgroundColor: _backgroundDark,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: _textDark, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: _textDark),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryDark,
      foregroundColor: _secondaryDark,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: _surfaceDark,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // side: const BorderSide(
        //   width: 2,
        //   color: Colors.black,
        // ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryDark,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: _secondaryDark),
  );
}
