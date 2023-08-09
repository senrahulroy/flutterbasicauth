import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/clonewithriverpod/main.dart';
import 'package:uiwithcomponent/clonewithriverpod/river_api_ui.dart';
import 'package:uiwithcomponent/riverpod/provider/mobile_number_noti.dart';
import 'package:uiwithcomponent/riverpod/repository/auth_repository.dart';
import 'package:uiwithcomponent/src/common_widgets/comman_button.dart';
import 'package:uiwithcomponent/src/common_widgets/input_text_field.dart';
import 'package:uiwithcomponent/src/pages/basic_component.dart';
import 'package:uiwithcomponent/src/pages/screen/auth_page.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
    final mobileWatch = ref.watch(mobileNumberProvider);
    mobileWatch.mobileEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobileWatch = ref.watch(mobileNumberProvider);
    final phoneWatch = ref.watch(authProvider);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        body: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInputTextField(
              controller: phoneWatch.phoneNumber,
              labelText: 'Enter Mobile',
              keyBoardType: TextInputType.phone,
              onChanged: (value) =>
                  mobileWatch.checkMobileNumberValidator(value),
              inputTextFormater: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              // focusNode: mobileWatch.mobileFocusNode,
            ),
            Gap(20.h),
            CustomeButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  PhoneAuthentication().phoneAuth(phoneWatch.phoneNumber.text);

                  // phoneWatch.phoneAuth(PhoneAuthProvider.PHONE_SIGN_IN_METHOD);
                }
                //   if (mobileWatch.mobileEditController.length == 10) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => OtpPage(
                //                   data: mobileWatch.mobileEditController.text,
                //                 )));
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         content: Text("Please enter valide Number")));
                //   }
              },
              isAllFieldsValid: true, //mobileWatch.isAllFieldsValid,
              child: const Text("Login"),
            ),
            Gap(20.h),
            CustomeButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BasicComponent()));
              },
              isAllFieldsValid: true,
              child: const Text("Basic Component"),
            ),
            Gap(20.h),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CloneMainScreen(),
                      ));
                },
                child: const Text("Clone Demo")),
            Gap(20.h),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RiverPodAPiScreen(),
                      ));
                },
                child: const Text("API Example with RiverPod")),
            Gap(20.h),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthPage(),
                      ));
                },
                child: const Text("Firebase Auth Login")),
            Gap(20.h),
          ],
        ),
      ),
    ));
  }
}
