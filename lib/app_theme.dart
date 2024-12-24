import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color bgGrey = Color(0xFFF6F8FA);

  // Utility function for responsive font size
  static double responsiveFontSize(BuildContext context, double multiplier) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth*multiplier;
    return size;
  }

  //light theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF735498),
      cardColor: const Color(0xFF735498),
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),

      // Text theme with responsive font sizes
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.sen(
          fontSize: responsiveFontSize(context, 0.07),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF32343E),
        ),
        headlineMedium: GoogleFonts.sen(
          fontSize: responsiveFontSize(context, 0.05),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF32343E),
        ),
        headlineSmall: GoogleFonts.sen(
          fontSize: responsiveFontSize(context, 0.05),
          color: const Color(0xFF32343E),
        ),
        bodyLarge: GoogleFonts.sen(
          fontSize: responsiveFontSize(context, 0.04),
          color: const Color(0xFF32343E),
        ),
        bodyMedium: GoogleFonts.sen(
          fontSize: responsiveFontSize(context, 0.03),
          color: const Color(0xFF32343E),
        ),
        bodySmall: GoogleFonts.sen(
          fontSize: responsiveFontSize(context, 0.028),
          color: const Color(0xFF32343E),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF735498),
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.sen(
            fontSize: responsiveFontSize(context, 0.05),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF32343E),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
