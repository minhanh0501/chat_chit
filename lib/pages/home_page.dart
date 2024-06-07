import 'package:flutter/material.dart';

import '../components/user_card.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 221, 200),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 138, 200, 139),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        title: const Text(
          "Chat chit with friend",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // Error
        if (snapshot.hasError) {
          return const Text("Error!!!");
        }

        // Hiển thị list user
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildChatCardList(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildChatCardList(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return ChatCard(
        email: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receivedEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
