import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/message_card.dart';
import '../components/textfield.dart';
import '../services/auth/auth_service.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverID;
  final String receivedEmail;

  const ChatPage({
    super.key,
    required this.receivedEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Message (Text Controller)
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      // Nếu focus được nhận
      if (focusNode.hasFocus) {
        // Sau 500ms, gọi hàm srcollDown() để cuộn xuống
        Future.delayed(
          const Duration(milliseconds: 500),
          () => srcollDown(),
        );
      }
    });

    // Sau 500ms, gọi hàm srcollDown() để cuộn xuống
    Future.delayed(
      const Duration(milliseconds: 500),
      () => srcollDown(),
    );
  }

  @override
  void dispose() {
    // Khi widget bị huỷ, giải phóng các tài nguyên
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Scroll Controller
  final ScrollController _scrollController = ScrollController();
  void srcollDown() {
    // Cuộn đến vị trí cuối cùng của trục dọc
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // SendMess method
  void sendMess() async {
    if (_messageController.text.isNotEmpty) {
      // Gửi tin nhắn
      await _chatService.sendMess(widget.receiverID, _messageController.text);
      // Xóa văn bản trong TextField sau khi gửi tin nhắn thành công
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receivedEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(context)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMess(widget.receiverID, senderID),
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
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    String senderID = _authService.getCurrentUser()!.uid;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Lấy ID của document
    String messageID = doc.id;

    // Lấy ID của chat room
    String chatRoomID = _chatService.getChatRoomID(widget.receiverID, senderID);

    // Kiểm tra có phải là người nhắn không
    bool isCurrentUser = data['senderID'] == senderID;

    // Chuyển item tin nhắn căn phải nếu là người gửi, còn không phải thì căn trái
    var alignmentMessage =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignmentMessage,
      child: MessageCard(
        message: data["message"],
        isCurrentUser: isCurrentUser,
        messageID: messageID,
        chatRoomID: chatRoomID,
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          Expanded(
            child: TextField_Edit(
              hintText: "  Type a message . . .",
              obscureText: false,
              controller: _messageController,
              focusNode: focusNode,
            ),
          ),

          // Nút gửi tin nhắn
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: sendMess,
              icon: const Icon(
                Icons.arrow_upward_rounded,
                size: 25,
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          )
        ],
      ),
    );
  }
}
