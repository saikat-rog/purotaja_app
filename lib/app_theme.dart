import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //light theme
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF735498),
      scaffoldBackgroundColor: Colors.white,
      //Theme for text
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.sen(
          fontSize: 40,
          fontWeight: FontWeight.bold,
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
