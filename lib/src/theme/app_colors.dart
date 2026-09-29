import 'package:flutter/material.dart';

/// Tiaw Jung's palette — the same mid-century formula as AimJung's (one
/// saturated lead hue, a warm counterpoint, olive/terracotta rounding out
/// the set), rebuilt around a harbor-blue primary instead of rust. See the
/// "Mid-Century Blue" design artifact this was approved from.
///
/// Unlike AimJung (a single fixed theme), Tiaw Jung ships both [light] and
/// [dark] sets and switches with the platform, so this is a [ThemeExtension]
/// rather than a plain static-const class — look it up via [AppColors.of].
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryDark,
    required this.primaryTint,
    required this.mustard,
    required this.mustardTint,
    required this.mustardInk,
    required this.olive,
    required this.oliveTint,
    required this.oliveInk,
    required this.terracotta,
    required this.scaffold,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textMuted,
    required this.textFaint,
    required this.textOnPrimary,
    required this.border,
    required this.inactive,
  });

  final Color primary;
  final Color primaryDark;
  final Color primaryTint;
  final Color mustard;
  final Color mustardTint;
  final Color mustardInk;
  final Color olive;
  final Color oliveTint;
  final Color oliveInk;
  final Color terracotta;
  final Color scaffold;
  final Color surface;
  final Color card;
  final Color textPrimary;
  final Color textMuted;
  final Color textFaint;
  final Color textOnPrimary;
  final Color border;
  final Color inactive;

  static const light = AppColors(
    primary: Color(0xFF2A6F8E),
    primaryDark: Color(0xFF1D4F66),
    primaryTint: Color(0xFFD9E8EC),
    mustard: Color(0xFFE3A72B),
    mustardTint: Color(0xFFFAEBCB),
    mustardInk: Color(0xFF7A5A12),
    olive: Color(0xFF7D8B4A),
    oliveTint: Color(0xFFE1E9D4),
    oliveInk: Color(0xFF4E5A2C),
    terracotta: Color(0xFFC1440E),
    scaffold: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFDFBF7),
    textPrimary: Color(0xFF1E2B33),
    textMuted: Color(0xFF5C6B72),
    textFaint: Color(0xFF8E9A98),
    textOnPrimary: Color(0xFFF3F8FA),
    border: Color(0xFFDCE2DE),
    inactive: Color(0xFFA9B4B0),
  );

  static const dark = AppColors(
    primary: Color(0xFF5FA8C7),
    primaryDark: Color(0xFF3D7F9E),
    primaryTint: Color(0xFF16303B),
    mustard: Color(0xFFF0BC55),
    mustardTint: Color(0xFF3A2E12),
    mustardInk: Color(0xFFF0D9A0),
    olive: Color(0xFF9CAD68),
    oliveTint: Color(0xFF202B16),
    oliveInk: Color(0xFFC3D19A),
    terracotta: Color(0xFFE06B3C),
    scaffold: Color(0xFF0F1A20),
    surface: Color(0xFF16242B),
    card: Color(0xFF1E2F37),
    textPrimary: Color(0xFFEAF1F4),
    textMuted: Color(0xFF9FB2B8),
    textFaint: Color(0xFF6B7E84),
    textOnPrimary: Color(0xFF0B1A21),
    border: Color(0xFF2A3B42),
    inactive: Color(0xFF56676C),
  );

  /// Looks up whichever [AppColors] is active for the current theme —
  /// every Tiaw Jung widget reads colors through this rather than a
  /// hardcoded static, so it repaints correctly on a light/dark switch.
  static AppColors of(BuildContext context) => Theme.of(context).extension<AppColors>()!;

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? primaryTint,
    Color? mustard,
    Color? mustardTint,
    Color? mustardInk,
    Color? olive,
    Color? oliveTint,
    Color? oliveInk,
    Color? terracotta,
    Color? scaffold,
    Color? surface,
    Color? card,
    Color? textPrimary,
    Color? textMuted,
    Color? textFaint,
    Color? textOnPrimary,
    Color? border,
    Color? inactive,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryTint: primaryTint ?? this.primaryTint,
      mustard: mustard ?? this.mustard,
      mustardTint: mustardTint ?? this.mustardTint,
      mustardInk: mustardInk ?? this.mustardInk,
      olive: olive ?? this.olive,
      oliveTint: oliveTint ?? this.oliveTint,
      oliveInk: oliveInk ?? this.oliveInk,
      terracotta: terracotta ?? this.terracotta,
      scaffold: scaffold ?? this.scaffold,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textFaint: textFaint ?? this.textFaint,
      textOnPrimary: textOnPrimary ?? this.textOnPrimary,
      border: border ?? this.border,
      inactive: inactive ?? this.inactive,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryTint: Color.lerp(primaryTint, other.primaryTint, t)!,
      mustard: Color.lerp(mustard, other.mustard, t)!,
      mustardTint: Color.lerp(mustardTint, other.mustardTint, t)!,
      mustardInk: Color.lerp(mustardInk, other.mustardInk, t)!,
      olive: Color.lerp(olive, other.olive, t)!,
      oliveTint: Color.lerp(oliveTint, other.oliveTint, t)!,
      oliveInk: Color.lerp(oliveInk, other.oliveInk, t)!,
      terracotta: Color.lerp(terracotta, other.terracotta, t)!,
      scaffold: Color.lerp(scaffold, other.scaffold, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textFaint: Color.lerp(textFaint, other.textFaint, t)!,
      textOnPrimary: Color.lerp(textOnPrimary, other.textOnPrimary, t)!,
      border: Color.lerp(border, other.border, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
    );
  }
}
