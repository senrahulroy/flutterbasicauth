import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mobileNumberProvider = ChangeNotifierProvider((ref) {
  return MobileNumberNotifier();
});

class MobileNumberNotifier extends ChangeNotifier {
  /// Mobile number TextEditing Controller
  TextEditingController mobileEditController = TextEditingController();
  TextEditingController otpVeriyController = TextEditingController();

  /// FocusNode for Mobile
  FocusNode mobileFocusNode = FocusNode();

  ///Phone String
  String strPhoneNumber = "";
  String strPhoneNumberError = "";
  String verificationId = "";

  bool isAllFieldsValid = false;

  ///Clear Provider value
  clearProvider() {
    strPhoneNumber = "";
    strPhoneNumberError = "";
    verificationId = "";
    isAllFieldsValid = false;
    notifyListeners();
  }

  checkMobileNumberValidator(String mobileNumner) {
    if (!isPhoneNumberValid(mobileNumner)) {
      if (mobileNumner.isEmpty) {
        isAllFieldsValid = false;
        strPhoneNumberError = "Please Enter Mobile Number";
      } else {
        isAllFieldsValid = false;
        strPhoneNumberError = "Please Enter Valid Mobile Number";
      }
    } else {
      isAllFieldsValid = true;
      strPhoneNumberError = "";
    }
    notifyListeners();
  }

  isPhoneNumberValid(String str) {
    if (str.isNotEmpty && str.length == 10) {
      return true;
    } else {
      return false;
    }
  }

  checkOtpValidator(String otp) {
    if (!isOtpLenthCheck(otp)) {
      if (otp.isEmpty) {
        isAllFieldsValid = false;
      } else {
        isAllFieldsValid = false;
      }
    } else {
      isAllFieldsValid = true;
    }
    notifyListeners();
  }

  isOtpLenthCheck(String str) {
    if (str.isNotEmpty && str.length == 6) {
      return true;
    } else {
      return false;
    }
  }
}
