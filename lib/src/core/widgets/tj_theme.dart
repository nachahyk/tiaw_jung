import 'package:flutter/material.dart';
import 'package:core_jung/core_jung.dart';

import 'package:tiaw_jung/src/theme/app_theme.dart';

/// Wraps a Tiaw Jung page in its own theme, independent of whatever theme
/// the shell (or another installed mini-app) applies globally — every
/// `TiawJungModule` route builder wraps its page in this.
class TjTheme extends StatelessWidget {
  const TjTheme({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MiniAppThemeSwitcher(light: AppTheme.light, dark: AppTheme.dark, child: child);
  }
}
