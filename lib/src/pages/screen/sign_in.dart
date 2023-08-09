import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/src/pages/screen/homescreen.dart';
import 'package:uiwithcomponent/src/pages/screen/phone_page.dart';
import 'package:uiwithcomponent/src/pages/screen/sign_up.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailIdController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passWordController = TextEditingController();
  final passWordFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey globalKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    emailIdController.clear();
    passWordController.clear();
  }

  void login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailIdController.text, password: passWordController.text);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(emailIdController.text),
        padding: const EdgeInsets.all(20),
      ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!.toString()),
        padding: const EdgeInsets.all(20),
      ));
    }

    //     .then((value) => null)
    //     .onError((error, stackTrace) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(error.toString())));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                      return 'please password';
                    }
                    return null;
                  },
                ),
                Gap(50.h),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                key: globalKey,
                              ),
                            ));
                      }
                    },
                    child: const Text('Login')),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account ?'),
                    TextButton(
                        onPressed: () {
                          debugPrint('Sign in Button press');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text('Sign Up')),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginWithPhone()));
                    },
                    child: const Text('Login with phone'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
