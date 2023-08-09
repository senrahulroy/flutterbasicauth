import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/src/common_widgets/input_text_field.dart';
import 'package:uiwithcomponent/src/pages/otp_page.dart';

class LoginWithPhone extends ConsumerStatefulWidget {
  const LoginWithPhone({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends ConsumerState<LoginWithPhone> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone number login '),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputTextField(
                controller: phoneNumberController,
                labelText: 'Enter Mobile number',
                keyBoardType: TextInputType.phone,

                // focusNode: mobileWatch.mobileFocusNode,
              ),
              Gap(20.h),
              ElevatedButton(
                  onPressed: () {
                    _auth.verifyPhoneNumber(
                      phoneNumber: '+91${phoneNumberController.text}',
                      verificationCompleted: (phoneAuthCredential) {},
                      verificationFailed: (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.message!.toString()),
                            padding: const EdgeInsets.all(20)));
                      },
                      codeSent: (verificationId, forceResendingToken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtpPage(verificationId: verificationId),
                            ));
                      },
                      codeAutoRetrievalTimeout: (verificationId) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(verificationId.toString()),
                            padding: const EdgeInsets.all(20)));
                      },
                    );
                  },
                  child: const Text("Send otp"))
            ],
          ),
        ),
      ),
    );
  }
}
