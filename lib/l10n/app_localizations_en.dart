// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSomethingWentWrong => 'Something went wrong';

  @override
  String get navBackToSwitcher => 'Back to Jung Studio';

  @override
  String get tripsTitle => 'My Trips';

  @override
  String get tripsEmptyTitle => 'No trips yet';

  @override
  String get tripsEmptyBody =>
      'Create a trip or join one with a code from a friend.';

  @override
  String get tripsCreateButton => 'Create Trip';

  @override
  String get tripsJoinButton => 'Join Trip';

  @override
  String get tripsLoadError => 'Failed to load trips';

  @override
  String get createTripTitle => 'Create Trip';

  @override
  String get createTripNameLabel => 'Trip Name';

  @override
  String get createTripNameRequired => 'Name is required';

  @override
  String get createTripDestinationLabel => 'Destination (optional)';

  @override
  String get createTripStartDateLabel => 'Start Date';

  @override
  String get createTripEndDateLabel => 'End Date';

  @override
  String get createTripSubmitButton => 'Create Trip';

  @override
  String get joinTripTitle => 'Join Trip';

  @override
  String get joinTripCodeLabel => 'Trip Code';

  @override
  String get joinTripCodeHint => 'e.g. PAI482';

  @override
  String get joinTripSubmitButton => 'Join';

  @override
  String get joinTripNotFound => 'No trip found with that code';

  @override
  String tripDetailDayLabel(int number, String date) {
    return 'Day $number · $date';
  }

  @override
  String get tripDetailEmptyDay => 'Nothing planned yet';

  @override
  String get tripDetailAddStopButton => 'Add Stop';

  @override
  String tripDetailJoinCode(String code) {
    return 'Join code: $code';
  }

  @override
  String get tripMembersTitle => 'Members';

  @override
  String get tripLeaveButton => 'Leave Trip';

  @override
  String get tripLeaveConfirmTitle => 'Leave this trip?';

  @override
  String get tripLeaveConfirmBody =>
      'You\'ll need the join code to come back in.';

  @override
  String get stopFormAddTitle => 'Add Stop';

  @override
  String get stopFormEditTitle => 'Edit Stop';

  @override
  String get stopFormNameLabel => 'What is it?';

  @override
  String get stopFormNameRequired => 'Name is required';

  @override
  String get stopFormDayLabel => 'Day';

  @override
  String get stopFormTimeLabel => 'Time (optional)';

  @override
  String get stopFormAddressLabel => 'Location';

  @override
  String get stopFormAddressHint => 'Tap to pick on map';

  @override
  String get stopFormNoteLabel => 'Note (optional)';

  @override
  String get stopFormSaveButton => 'Save Stop';

  @override
  String get stopFormDeleteButton => 'Remove Stop';

  @override
  String get locationPickerTitle => 'Pick Location';

  @override
  String get locationSearchHint => 'Search for a place';

  @override
  String get locationPickerTapToPlace => 'Tap the map to place a pin';

  @override
  String get locationResolvingAddress => 'Finding address…';

  @override
  String get locationConfirmButton => 'Confirm';

  @override
  String get locationPermissionDenied => 'Location permission denied';

  @override
  String get locationSearchNoResults => 'No results found';
}
