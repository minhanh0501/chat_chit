import 'package:flutter/material.dart';

// ignore: camel_case_types
class TextField_Edit extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const TextField_Edit({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 31, 94, 32)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 32, 21, 150)),
          ),
          fillColor: const Color.fromARGB(255, 109, 194, 145),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
