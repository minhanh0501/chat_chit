import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String email;
  final void Function()? onTap;

  const ChatCard({
    super.key,
    required this.email,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      color: const Color.fromARGB(255, 244, 254, 244), //màu của user
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            // User avatar
            leading: const CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),

            // User name
            title: Text(email),
          ),
        ),
      ),
    );
  }
}
