import 'package:flutter/material.dart';

// ignore: camel_case_types
class Buttom_Edit extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const Buttom_Edit({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 171, 253, 181),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
