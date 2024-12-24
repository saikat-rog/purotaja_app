import 'package:flutter/material.dart';

class AppTheme {
  static const Color bgGrey = Color(0xFFF6F8FA);

  // Utility function for responsive font size
  static double responsiveFontSize(BuildContext context, double multiplier) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * multiplier;
    return size;
  }

  // Light theme
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF735498),
      cardColor: const Color(0xFF735498),
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),

      // Text theme with responsive font sizes and custom font
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'aeonik',
          fontSize: responsiveFontSize(context, 0.07),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF32343E),
        ),
        headlineMedium: TextStyle(
          fontFamily: 'aeonik',
          fontSize: responsiveFontSize(context, 0.05),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF32343E),
        ),
        headlineSmall: TextStyle(
          fontFamily: 'aeonik',
          fontSize: responsiveFontSize(context, 0.05),
          color: const Color(0xFF32343E),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'aeonik',
          fontSize: responsiveFontSize(context, 0.04),
          color: const Color(0xFF32343E),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'aeonik',
          fontSize: responsiveFontSize(context, 0.03),
          color: const Color(0xFF32343E),
        ),
        bodySmall: TextStyle(
          fontFamily: 'aeonik',
          fontSize: responsiveFontSize(context, 0.028),
          color: const Color(0xFF32343E),
        ),
      ),

      // Elevated button theme with custom font
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF735498),
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontFamily: 'AeonikOVERVIEW',
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
