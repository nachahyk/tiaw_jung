import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWentWrong;

  /// No description provided for @navBackToSwitcher.
  ///
  /// In en, this message translates to:
  /// **'Back to Jung Studio'**
  String get navBackToSwitcher;

  /// No description provided for @tripsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get tripsTitle;

  /// No description provided for @tripsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get tripsEmptyTitle;

  /// No description provided for @tripsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Create a trip or join one with a code from a friend.'**
  String get tripsEmptyBody;

  /// No description provided for @tripsCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get tripsCreateButton;

  /// No description provided for @tripsJoinButton.
  ///
  /// In en, this message translates to:
  /// **'Join Trip'**
  String get tripsJoinButton;

  /// No description provided for @tripsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load trips'**
  String get tripsLoadError;

  /// No description provided for @createTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get createTripTitle;

  /// No description provided for @createTripNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Trip Name'**
  String get createTripNameLabel;

  /// No description provided for @createTripNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get createTripNameRequired;

  /// No description provided for @createTripDestinationLabel.
  ///
  /// In en, this message translates to:
  /// **'Destination (optional)'**
  String get createTripDestinationLabel;

  /// No description provided for @createTripStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get createTripStartDateLabel;

  /// No description provided for @createTripEndDateLabel.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get createTripEndDateLabel;

  /// No description provided for @createTripSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get createTripSubmitButton;

  /// No description provided for @joinTripTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Trip'**
  String get joinTripTitle;

  /// No description provided for @joinTripCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Trip Code'**
  String get joinTripCodeLabel;

  /// No description provided for @joinTripCodeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. PAI482'**
  String get joinTripCodeHint;

  /// No description provided for @joinTripSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get joinTripSubmitButton;

  /// No description provided for @joinTripNotFound.
  ///
  /// In en, this message translates to:
  /// **'No trip found with that code'**
  String get joinTripNotFound;

  /// No description provided for @tripDetailDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day {number} · {date}'**
  String tripDetailDayLabel(int number, String date);

  /// No description provided for @tripDetailEmptyDay.
  ///
  /// In en, this message translates to:
  /// **'Nothing planned yet'**
  String get tripDetailEmptyDay;

  /// No description provided for @tripDetailAddStopButton.
  ///
  /// In en, this message translates to:
  /// **'Add Stop'**
  String get tripDetailAddStopButton;

  /// No description provided for @tripDetailJoinCode.
  ///
  /// In en, this message translates to:
  /// **'Join code: {code}'**
  String tripDetailJoinCode(String code);

  /// No description provided for @tripMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get tripMembersTitle;

  /// No description provided for @tripLeaveButton.
  ///
  /// In en, this message translates to:
  /// **'Leave Trip'**
  String get tripLeaveButton;

  /// No description provided for @tripLeaveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave this trip?'**
  String get tripLeaveConfirmTitle;

  /// No description provided for @tripLeaveConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need the join code to come back in.'**
  String get tripLeaveConfirmBody;

  /// No description provided for @stopFormAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Stop'**
  String get stopFormAddTitle;

  /// No description provided for @stopFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Stop'**
  String get stopFormEditTitle;

  /// No description provided for @stopFormNameLabel.
  ///
  /// In en, this message translates to:
  /// **'What is it?'**
  String get stopFormNameLabel;

  /// No description provided for @stopFormNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get stopFormNameRequired;

  /// No description provided for @stopFormDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get stopFormDayLabel;

  /// No description provided for @stopFormTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time (optional)'**
  String get stopFormTimeLabel;

  /// No description provided for @stopFormAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get stopFormAddressLabel;

  /// No description provided for @stopFormAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to pick on map'**
  String get stopFormAddressHint;

  /// No description provided for @stopFormNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get stopFormNoteLabel;

  /// No description provided for @stopFormSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Stop'**
  String get stopFormSaveButton;

  /// No description provided for @stopFormDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Remove Stop'**
  String get stopFormDeleteButton;

  /// No description provided for @locationPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick Location'**
  String get locationPickerTitle;

  /// No description provided for @locationSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a place'**
  String get locationSearchHint;

  /// No description provided for @locationPickerTapToPlace.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to place a pin'**
  String get locationPickerTapToPlace;

  /// No description provided for @locationResolvingAddress.
  ///
  /// In en, this message translates to:
  /// **'Finding address…'**
  String get locationResolvingAddress;

  /// No description provided for @locationConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get locationConfirmButton;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// No description provided for @locationSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get locationSearchNoResults;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
