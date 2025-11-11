import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color(0xFF13EC92);
  static const backgroundDark = Color(0xFF10221A);
  static const cardDark = Color(0xFF193328);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundDark,
      textTheme: GoogleFonts.lexendTextTheme(ThemeData.dark().textTheme),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: primaryColor,
      ).copyWith(
        secondary: primaryColor,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundDark,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
