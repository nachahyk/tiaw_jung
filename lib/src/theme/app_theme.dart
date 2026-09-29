import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tiaw_jung/src/theme/app_colors.dart';

/// Builds Tiaw Jung's `ThemeData` for a given [AppColors] set — [light] and
/// [dark] below are the two the app actually switches between.
abstract class AppTheme {
  const AppTheme._();

  static final light = _build(AppColors.light, Brightness.light);
  static final dark = _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final base = GoogleFonts.manropeTextTheme(
      brightness == Brightness.light ? ThemeData.light().textTheme : ThemeData.dark().textTheme,
    ).apply(
      bodyColor: colors.textPrimary,
      displayColor: colors.textPrimary,
    );

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colors.scaffold,
      canvasColor: colors.surface,
      fontFamily: GoogleFonts.manrope().fontFamily,
      fontFamilyFallback: const ['Noto Sans Thai'],
      textTheme: base,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.textOnPrimary,
        secondary: colors.mustard,
        onSecondary: colors.textPrimary,
        error: colors.terracotta,
        onError: colors.textOnPrimary,
        surface: colors.card,
        onSurface: colors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.card,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide(color: colors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide(color: colors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide(color: colors.primary, width: 1.5)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.textOnPrimary,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 4,
          shadowColor: colors.primary.withValues(alpha: 0.45),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.textOnPrimary,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 4,
          shadowColor: colors.primary.withValues(alpha: 0.45),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary, width: 1.5),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colors.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.card,
        foregroundColor: colors.primary,
        shape: const CircleBorder(),
        elevation: 4,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? colors.card : colors.card,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? colors.primary : colors.border,
        ),
      ),
      dividerTheme: DividerThemeData(color: colors.border, space: 1),
      extensions: [colors],
    );
  }
}
