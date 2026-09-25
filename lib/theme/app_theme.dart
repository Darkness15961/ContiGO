import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ContiGO visual identity: human connection, not admin purple.
class AppColors {
  static const ink = Color(0xFF14221E);
  static const inkSoft = Color(0xFF3A4A45);
  static const mist = Color(0xFFF2F5F3);
  static const paper = Color(0xFFFAFBFA);
  static const teal = Color(0xFF0B6E6A);
  static const tealSoft = Color(0xFFD8EFED);
  static const ember = Color(0xFFC45C26);
  static const emberSoft = Color(0xFFF8E6DC);
  static const line = Color(0xFFD9E0DC);
  static const success = Color(0xFF1F7A4D);
  static const muted = Color(0xFF6B7A74);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.mist,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.teal,
        primary: AppColors.teal,
        secondary: AppColors.ember,
        surface: AppColors.paper,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.dmSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mist,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.paper,
        selectedItemColor: AppColors.teal,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.line),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.tealSoft,
        selectedColor: AppColors.teal,
        labelStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.ink),
        secondaryLabelStyle: GoogleFonts.dmSans(fontSize: 13, color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.line, thickness: 1),
    );
  }
}

TextStyle displayStyle({double size = 32, FontWeight weight = FontWeight.w600, Color? color}) {
  return GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.ink,
    height: 1.15,
  );
}
