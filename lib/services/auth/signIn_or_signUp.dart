// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../pages/login_page.dart';
import '../../pages/register_page.dart';

class SignInOrSignUp extends StatefulWidget {
  const SignInOrSignUp({super.key});

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp> {
  bool check = true;

  void togglePage() {
    setState(() {
      check = !check;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (check) {
      return LoginPage(
        onTap: togglePage,
      );
    } else {
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}
