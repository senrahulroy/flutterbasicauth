import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uiwithcomponent/src/pages/screen/homescreen.dart';
import 'package:uiwithcomponent/src/pages/screen/sign_in.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = FirebaseAuth.instance.authStateChanges();
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: authState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
