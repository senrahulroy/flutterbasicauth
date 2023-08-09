import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/src/pages/screen/sign_in.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final emailIdController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passWordController = TextEditingController();
  final passWordFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailIdController.clear();
    passWordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Firebase Email & \nPassword example',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Gap(50.h),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailIdController,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter email',
                    label: Text('Email'),
                  ),
                  validator: (value) {
                    // const pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // final regex = RegExp(pattern);
                    if (value!.isEmpty) {
                      // if (regex.hasMatch(value)) {
                      //   return "";
                      // } else {
                      //   return 'Please enter valid email id ex: admail@domainname.com';
                      // }
                      return 'Enter email';
                    } else {
                      return null;
                    }
                  },
                ),
                Gap(20.h),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passWordController,
                  obscureText: true,
                  focusNode: passWordFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter password',
                    label: Text('Password'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please password';
                    }
                    return null;
                  },
                ),
                Gap(50.h),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        loading = true;
                        await _auth.createUserWithEmailAndPassword(
                          email: emailIdController.text.toString(),
                          password: passWordController.text.toString(),
                        );
                        setState(() {
                          loading = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        debugPrint(e.message);
                        loading = true;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.message!.toString()),
                          padding: const EdgeInsets.all(20),
                        ));

                        setState(() {
                          loading = false;
                        });
                      }
                      // setState(() {});

                      //     .then((value) {
                      //   setState(() {
                      //     loading = false;
                      //   });
                      // }).onError((error, stackTrace) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(error.toString()),
                      //     ),
                      //   );
                      //   setState(() {
                      //     loading = false;
                      //   });
                      // });
                    }
                  },
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?'),
                    TextButton(
                        onPressed: () {
                          debugPrint('Sign up Button press');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                        child: const Text('Login ')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
