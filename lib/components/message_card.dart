// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../services/chat/chat_service.dart';

class MessageCard extends StatefulWidget {
  final String chatRoomID;
  final String messageID;
  final String message;
  final bool isCurrentUser;

  const MessageCard({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageID,
    required this.chatRoomID,
  });

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showBottomSheet(
            widget.isCurrentUser, widget.chatRoomID, widget.messageID);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        decoration: BoxDecoration(
            color: widget.isCurrentUser
                ? const Color.fromARGB(255, 204, 228, 254)
                : const Color.fromARGB(255, 250, 220, 230),
            border: Border.all(
              color: widget.isCurrentUser
                  ? const Color.fromARGB(255, 103, 175, 253)
                  : Colors.pink.shade200,
            ),
            borderRadius: BorderRadius.circular(40)),
        child: Text(
          widget.message,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Tuỳ chỉnh tin nhắn (edit, detele)
  void _showBottomSheet(bool isCurrentUser, String chatRoomID, messageID) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 238, 238, 238),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 12.0,
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16.0),
              ListView(
                shrinkWrap: true,
                children: [
                  if (isCurrentUser) ...[
                    ListTile(
                      leading: const Icon(Icons.edit, color: Colors.blue),
                      title: const Text("Edit"),
                      onTap: () async {
                        await _showEditDialog(
                          currentMessage: widget.message,
                          onSave: (newMessage) async {
                            await ChatService()
                                .editMess(chatRoomID, messageID, newMessage);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: const Text("Delete"),
                      onTap: () async {
                        _showDeleteDialog(
                          onConfirm: () async {
                            await ChatService()
                                .deleteMess(chatRoomID, messageID);
                            Navigator.of(context).pop(); // Đóng bottom sheet
                          },
                        );
                        // Đóng bottom sheet
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hiển thị hộp thoại Edit
  Future<void> _showEditDialog({
    required String currentMessage,
    required Function(String) onSave,
  }) async {
    // Tạo một TextEditingController với nội dung tin nhắn hiện tại
    final TextEditingController messageController =
        TextEditingController(text: currentMessage);

    // Hiển thị một hộp thoại AlertDialog
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Message"),
        content: TextField(
          controller: messageController,
          autofocus: true,
          maxLines: null,
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("Save"),
            onPressed: () {
              final newMessage = messageController.text.trim();
              onSave(newMessage);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // Hiển thị hộp thoại Delete
  void _showDeleteDialog({
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
