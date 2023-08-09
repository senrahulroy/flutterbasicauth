import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  const AuthRepository(this._auth);

  Future<void> mobileNumberSign(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          SnackBar(content: Text(e.message.toString()));
        },
        codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(
              context: context,
              codeController: codeController,
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim());
                await _auth.signInWithCredential(credential);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              });
        }),
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
}

class FirebaseAuthMethods {}

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text("Enter OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: codeController,
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onPressed,
                child: const Text('Done'),
              ),
            ],
          ));
}

// start new phone login with changenotifier
class PhoneAuthentication extends ChangeNotifier {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpVerify = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  var verificationId = '';

  Future<void> phoneAuth(String phoneNo) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        if (error.code == 'Invalid-phone-number') {
          const SnackBar(
              content: Text('The provided phone number is not valid'));
        } else {
          const SnackBar(content: Text('Something went wrong. try again'));
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String smsCode) async {
    var creditial = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode));

    // check user in null then set a value in boolen

    var result = (creditial.user != null) ? true : false;
    return result;
  }
}

// create a provider for phone auth
final authProvider = ChangeNotifierProvider((ref) {
  return PhoneAuthentication();
});
