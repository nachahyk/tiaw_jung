import 'package:flutter/material.dart';
import 'package:core_jung/core_jung.dart';

import 'package:tiaw_jung/src/theme/app_colors.dart';

/// Shared header for pushed pages: a back button, a title, and a bottom
/// border, in Tiaw Jung's own theme-aware [AppColors].
class TjPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const TjPageHeader({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return MiniAppPageHeader(
      title: title,
      backgroundColor: colors.surface,
      borderColor: colors.border,
      badgeColor: colors.card,
      iconColor: colors.textPrimary,
      titleColor: colors.textPrimary,
      actions: actions,
    );
  }
}
