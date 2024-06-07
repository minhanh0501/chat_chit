import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/home_page.dart';
import 'signIn_or_signUp.dart';

// Kiểm soát quyền truy cập và điều hướng người dùng
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Ktra trạng thái của snapshot để hiển thị trang
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const SignInOrSignUp();
          }
        },
      ),
    );
  }
}
