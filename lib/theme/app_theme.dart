import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ContiGO — violeta Continental como identidad de conexión.
/// 70% blanco/claros · 20% violeta · 10% negro/contraste
class AppColors {
  static const violet = Color(0xFF6C2BD9);
  static const violetDeep = Color(0xFF4B1FA6);
  static const violetSoft = Color(0xFFF1EBFF);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF171717);
  static const grayDark = Color(0xFF555555);
  static const grayLight = Color(0xFFE8E8E8);
  static const bgSoft = Color(0xFFF8F7FA);
  static const violetMid = Color(0xFF7C3AED);
  static const accentWarm = Color(0xFFFF8A4C);
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
        onSecondary: AppColors.white,
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
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 24,
          fontWeight: FontWeight.w600,
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
          shadowColor: AppColors.violet.withValues(alpha: 0.35),
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.violetDeep,
          side: const BorderSide(color: AppColors.violet, width: 1.4),
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.violet,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF3F0F8),
        hintStyle: GoogleFonts.dmSans(color: AppColors.grayDark),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          borderSide: const BorderSide(color: AppColors.violet, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.violetSoft,
        selectedColor: AppColors.violet,
        labelStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.violetDeep),
        secondaryLabelStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.white),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.grayLight, thickness: 1),
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
  double size = 32,
  FontWeight weight = FontWeight.w600,
  Color? color,
}) {
  return GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.black,
    height: 1.15,
  );
}

TextStyle brandStyle({double size = 36}) {
  return GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: AppColors.violetDeep,
    letterSpacing: -0.5,
  );
}
