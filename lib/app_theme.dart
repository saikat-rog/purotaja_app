import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color bgGrey = Color(0xFFF6F8FA);
  //light theme
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF735498),
      cardColor: const Color(0xFF735498),
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),

      //Theme for text
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.sen(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF32343E),
        ),
        headlineMedium: GoogleFonts.sen(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF32343E),
        ),
        headlineSmall: GoogleFonts.sen(
          fontSize: 20,
          color: const Color(0xFF32343E),
        ),
        bodyLarge: GoogleFonts.sen(
          fontSize: 16,
          color: const Color(0xFF32343E),
        ),
        bodyMedium: GoogleFonts.sen(
          fontSize: 14,
          color: const Color(0xFF32343E),
        ),
      ),
      //Theme for Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF735498), // Button background color
          foregroundColor: Colors.white, // Button text color
          textStyle: GoogleFonts.sen(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF32343E),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Slightly rounded corners
          ),
        ),
      ),
    );
  }

  //apply dark theme if needed later
}
