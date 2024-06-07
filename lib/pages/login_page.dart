import 'package:flutter/material.dart';

import '../components/buttom.dart';
import '../components/textfield.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  // Email và mật khẩu (Text controller)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onTap;

  LoginPage({
    super.key,
    this.onTap,
  });

  // Login method
  void login(BuildContext context) async {
    final auth = AuthService();
    try {
      await auth.signIn(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 221, 200),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/mayman.jpg',
                width: 140,
                height: 140,
              ),

              // Tên app
              const Text(
                'Chat Chit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 50),

              // Email
              TextField_Edit(
                hintText: 'Email . . . ',
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 10),

              // Mật khẩu
              TextField_Edit(
                hintText: 'Password . . . ',
                obscureText: true,
                controller: _pwController,
              ),

              const SizedBox(height: 25),

              // Nút login
              Buttom_Edit(
                text: 'Login',
                onTap: () => login(context),
              ),

              const SizedBox(height: 25),

              // Chọn register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No account ? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
