// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get commonCancel => 'ยกเลิก';

  @override
  String get commonSave => 'บันทึก';

  @override
  String get commonDelete => 'ลบ';

  @override
  String get commonSomethingWentWrong => 'เกิดข้อผิดพลาด';

  @override
  String get navBackToSwitcher => 'กลับไป Jung Studio';

  @override
  String get tripsTitle => 'ทริปของฉัน';

  @override
  String get tripsEmptyTitle => 'ยังไม่มีทริป';

  @override
  String get tripsEmptyBody => 'สร้างทริปใหม่ หรือเข้าร่วมด้วยรหัสจากเพื่อน';

  @override
  String get tripsCreateButton => 'สร้างทริป';

  @override
  String get tripsJoinButton => 'เข้าร่วมทริป';

  @override
  String get tripsLoadError => 'โหลดรายการทริปไม่สำเร็จ';

  @override
  String get createTripTitle => 'สร้างทริป';

  @override
  String get createTripNameLabel => 'ชื่อทริป';

  @override
  String get createTripNameRequired => 'กรุณากรอกชื่อทริป';

  @override
  String get createTripDestinationLabel => 'จุดหมาย (ไม่บังคับ)';

  @override
  String get createTripStartDateLabel => 'วันเริ่มต้น';

  @override
  String get createTripEndDateLabel => 'วันสิ้นสุด';

  @override
  String get createTripSubmitButton => 'สร้างทริป';

  @override
  String get joinTripTitle => 'เข้าร่วมทริป';

  @override
  String get joinTripCodeLabel => 'รหัสทริป';

  @override
  String get joinTripCodeHint => 'เช่น PAI482';

  @override
  String get joinTripSubmitButton => 'เข้าร่วม';

  @override
  String get joinTripNotFound => 'ไม่พบทริปที่ใช้รหัสนี้';

  @override
  String tripDetailDayLabel(int number, String date) {
    return 'วันที่ $number · $date';
  }

  @override
  String get tripDetailEmptyDay => 'ยังไม่มีแผนสำหรับวันนี้';

  @override
  String get tripDetailAddStopButton => 'เพิ่มจุดหมาย';

  @override
  String tripDetailJoinCode(String code) {
    return 'รหัสเข้าร่วม: $code';
  }

  @override
  String get tripMembersTitle => 'สมาชิก';

  @override
  String get tripLeaveButton => 'ออกจากทริป';

  @override
  String get tripLeaveConfirmTitle => 'ออกจากทริปนี้ใช่ไหม?';

  @override
  String get tripLeaveConfirmBody =>
      'คุณจะต้องใช้รหัสเข้าร่วมเพื่อกลับเข้ามาอีกครั้ง';

  @override
  String get stopFormAddTitle => 'เพิ่มจุดหมาย';

  @override
  String get stopFormEditTitle => 'แก้ไขจุดหมาย';

  @override
  String get stopFormNameLabel => 'ชื่อสถานที่';

  @override
  String get stopFormNameRequired => 'กรุณากรอกชื่อสถานที่';

  @override
  String get stopFormDayLabel => 'วันที่';

  @override
  String get stopFormTimeLabel => 'เวลา (ไม่บังคับ)';

  @override
  String get stopFormAddressLabel => 'ตำแหน่ง';

  @override
  String get stopFormAddressHint => 'แตะเพื่อเลือกบนแผนที่';

  @override
  String get stopFormNoteLabel => 'โน้ต (ไม่บังคับ)';

  @override
  String get stopFormSaveButton => 'บันทึกจุดหมาย';

  @override
  String get stopFormDeleteButton => 'ลบจุดหมาย';

  @override
  String get locationPickerTitle => 'เลือกตำแหน่ง';

  @override
  String get locationSearchHint => 'ค้นหาสถานที่';

  @override
  String get locationPickerTapToPlace => 'แตะบนแผนที่เพื่อปักหมุด';

  @override
  String get locationResolvingAddress => 'กำลังค้นหาที่อยู่…';

  @override
  String get locationConfirmButton => 'ยืนยัน';

  @override
  String get locationPermissionDenied => 'ไม่ได้รับอนุญาตให้เข้าถึงตำแหน่ง';

  @override
  String get locationSearchNoResults => 'ไม่พบผลลัพธ์';
}
