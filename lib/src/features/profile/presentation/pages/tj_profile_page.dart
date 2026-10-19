import 'package:flutter/material.dart';
import 'package:jung_studio_auth/jung_studio_auth.dart';

import 'package:tiaw_jung/l10n/app_localizations.dart';
import 'package:tiaw_jung/src/core/widgets/tj_page_header.dart';

/// Tiaw Jung's profile screen — the shared [AccountProfilePage] with Tiaw Jung's
/// own strings and page header; its colors come from the [TjTheme] the
/// route wraps it in.
class TjProfilePage extends StatelessWidget {
  const TjProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AccountProfilePage(
      appBar: TjPageHeader(title: l10n.profileTitle),
      strings: AccountProfilePageStrings(
        title: l10n.profileTitle,
        guestName: l10n.profileGuestName,
        guestBadge: l10n.profileGuestBadge,
        emailLabel: l10n.profileEmailLabel,
        phoneLabel: l10n.profilePhoneLabel,
        addressLabel: l10n.profileAddressLabel,
        memberSinceLabel: l10n.profileMemberSinceLabel,
        notSet: l10n.profileNotSet,
        editButton: l10n.profileEditButton,
        editTitle: l10n.profileEditTitle,
        fullNameLabel: l10n.profileFullNameLabel,
        fullNameRequired: l10n.profileFullNameRequired,
        saveButton: l10n.commonSave,
        savedMessage: l10n.profileSavedMessage,
        signOutButton: l10n.profileSignOut,
      ),
    );
  }
}
