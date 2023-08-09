import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:uiwithcomponent/riverpod/provider/mobile_number_noti.dart';
import 'package:uiwithcomponent/src/common_widgets/comman_button.dart';
import 'package:uiwithcomponent/src/pages/screen/homescreen.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String verificationId;
  const OtpPage({Key? key, required this.verificationId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final auth = FirebaseAuth.instance;
  final otpContoller = TextEditingController();
  final String value = '';
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final mobileWatch = ref.watch(mobileNumberProvider);
      mobileWatch.clearProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mobileWatch = ref.watch(mobileNumberProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mobileWatch.mobileEditController.text),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: true,
                controller: otpContoller,
                // blinkWhenObscuring: true,
                // obscuringCharacter: '*',
                // obscuringWidget: FlutterLogo(
                //   size: 20.h,
                // ),

                // onCompleted: (value) => mobileWatch.checkOtpValidator(value),
                onChanged: (value) => mobileWatch.checkOtpValidator(value),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]'),
                  ),
                ],
              ),
              Gap(9.h),
              CustomeButton(
                onPressed: () async {
                  final authCredentail = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otpContoller.text.toString(),
                  );

                  try {
                    await auth.signInWithCredential(authCredentail);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } on FirebaseAuth catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                      padding: const EdgeInsets.all(20),
                    ));
                  }
                },
                isAllFieldsValid: mobileWatch.isAllFieldsValid,
                child: const Text('Verify OTP'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
