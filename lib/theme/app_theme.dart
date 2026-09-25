import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta ContiGO (jerarquía de importancia, de arriba hacia abajo).
/// 1. #81308C  2. #521E59  3. #F2E1AC  4. #F29422  5. #F2F2F2
class AppColors {
  /// 1 — Principal: botones, nav activa, headers, acciones
  static const primary = Color(0xFF81308C);
  /// 2 — Profundo: manchas, títulos, texto fuerte, estados
  static const deep = Color(0xFF521E59);
  /// 3 — Suave: chips, fondos de acento, tags
  static const cream = Color(0xFFF2E1AC);
  /// 4 — Acento: CTAs especiales, barras, highlights
  static const orange = Color(0xFFF29422);
  /// 5 — Neutro: fondo de pantallas
  static const mist = Color(0xFFF2F2F2);

  // —— Alias usados en toda la app (misma paleta) ——
  static const violet = primary;
  static const violetDeep = deep;
  static const violetBlotch = deep;
  static const violetSoft = cream;
  static const violetMist = mist;
  static const accentWarm = orange;
  static const accentPink = orange;
  static const bgSoft = mist;
  static const inputFill = Color(0xFFFFFFFF);
  static const grayLight = Color(0xFFE6E6E6);
  static const grayDark = Color(0xFF6B5270);
  static const black = deep;
  static const white = Color(0xFFFFFFFF);
  /// Estado positivo (semántico, no de marca)
  static const success = Color(0xFF2F9E6B);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.mist,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.deep,
        tertiary: AppColors.orange,
        surface: AppColors.white,
        onSurface: AppColors.deep,
        outline: AppColors.grayLight,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.dmSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.deep,
        displayColor: AppColors.deep,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mist,
        foregroundColor: AppColors.deep,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.deep,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.cream,
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
          foregroundColor: AppColors.deep,
          side: const BorderSide(color: AppColors.primary, width: 1.4),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
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
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cream,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.dmSans(fontSize: 12, color: AppColors.deep),
        secondaryLabelStyle: GoogleFonts.dmSans(fontSize: 12, color: AppColors.white),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
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
    color: color ?? AppColors.deep,
    height: 1.2,
  );
}

TextStyle brandStyle({double size = 36, Color? color}) {
  return GoogleFonts.dmSans(
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: color ?? AppColors.deep,
    letterSpacing: -0.4,
  );
}
