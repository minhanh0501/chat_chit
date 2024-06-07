import 'package:flutter/material.dart';

import '../components/buttom.dart';
import '../components/textfield.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  // Email và mật khẩu (Text controller)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _comfirmpwController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  // Register method
  void register(BuildContext context) async {
    final auth = AuthService();

    if (_pwController.text == _comfirmpwController.text) {
      try {
        await auth.signUp(
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
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match !!!"),
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
                width: 80,
                height: 80,
              ),

              const SizedBox(height: 20),

              // Text
              const Text(
                "Let's create your own account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 30),

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

              const SizedBox(height: 10),

              // Xác nhận mật khẩu
              TextField_Edit(
                hintText: 'Comfirm password . . . ',
                obscureText: true,
                controller: _comfirmpwController,
              ),

              const SizedBox(height: 25),

              // Nút login
              Buttom_Edit(
                text: 'Register',
                onTap: () => register(context),
              ),

              const SizedBox(height: 25),

              // Chọn login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login now",
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
