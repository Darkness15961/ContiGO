import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta alineada al mockup de referencia (violeta + manchas + blanco).
class AppColors {
  /// Header / botones principales
  static const violet = Color(0xFF6B4EFF);
  /// Manchas y estados activos
  static const violetDeep = Color(0xFF4F2FD6);
  /// Mancha más oscura
  static const violetBlotch = Color(0xFF3D22B0);
  /// Fondos chips / soft
  static const violetSoft = Color(0xFFEEE8FF);
  static const violetMist = Color(0xFFF6F3FF);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF1A1A2E);
  static const grayDark = Color(0xFF6B6B80);
  static const grayLight = Color(0xFFE8E6F0);
  static const inputFill = Color(0xFFF3F2F8);
  static const bgSoft = Color(0xFFF7F6FB);
  static const accentWarm = Color(0xFFFF8A3D);
  static const accentPink = Color(0xFFC084FC);
  static const success = Color(0xFF22C55E);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bgSoft,
      colorScheme: const ColorScheme.light(
        primary: AppColors.violet,
        onPrimary: AppColors.white,
        secondary: AppColors.violetDeep,
        surface: AppColors.white,
        onSurface: AppColors.black,
        outline: AppColors.grayLight,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.dmSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgSoft,
        foregroundColor: AppColors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.violet,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.violetSoft,
          disabledForegroundColor: AppColors.grayDark,
          elevation: 0,
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.violetDeep,
          side: const BorderSide(color: AppColors.violet, width: 1.4),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.violet,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        hintStyle: GoogleFonts.dmSans(color: AppColors.grayDark, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.violet, width: 1.4),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.violetSoft,
        selectedColor: AppColors.violet,
        labelStyle: GoogleFonts.dmSans(fontSize: 12, color: AppColors.violetDeep),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.violet,
        unselectedItemColor: AppColors.grayDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}

TextStyle displayStyle({
  double size = 28,
  FontWeight weight = FontWeight.w700,
  Color? color,
}) {
  return GoogleFonts.dmSans(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.black,
    height: 1.2,
  );
}

TextStyle brandStyle({double size = 36, Color? color}) {
  return GoogleFonts.dmSans(
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: color ?? AppColors.violetDeep,
    letterSpacing: -0.4,
  );
}
