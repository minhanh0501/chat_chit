import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/message.dart';

class ChatService {
  // Khởi tạo và lưu trữ một instance để tương tác với Firestore và Auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Lấy id chat room
  String getChatRoomID(String userID, String otherUserID) {
    List<String> idRoom = [userID, otherUserID];
    idRoom.sort(); // sap xep vi co the 2 ng nhan se nhan 2 id khac nhau
    return idRoom.join('_'); //noi id_room dang 'id01_id02'
  }

  // Phương thức lấy luồng dữ liệu về các người dùng từ Firestore
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    // Lấy một luồng dữ liệu từ bộ sưu tập "Users" trong Firestore
    return _firestore.collection("Users").snapshots().map((snapshot) {
      // Chuyển đổi từng document snapshot thành một đối tượng Map đại diện cho người dùng
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // Gửi tin nhắn (Create)
  Future<void> sendMess(String receiverID, message) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

//Create new mess
    Message newmessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

// Create room mix id 2 user
    List<String> idRoom = [currentUserID, receiverID];
    idRoom.sort(); // sap xep vi co the 2 ng nhan se nhan 2 id khac nhau
    String chatRoomID = idRoom.join('_'); //noi id_room dang 'id01_id02'

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newmessage.toMap());
  }

  // Lấy tin nhắn để hiển thị (Read)
  Stream<QuerySnapshot> getMess(String userID, otherUserID) {
    // Create room mix id 2 user
    List<String> idRoom = [userID, otherUserID];
    idRoom.sort(); // sap xep vi co the 2 ng nhan se nhan 2 id khac nhau
    String chatRoomID = idRoom.join('_'); //noi id_room dang 'id01_id02'

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // Sửa tin nhắn (Edit)
  Future<void> editMess(String chatRoomID, messageID, newMessage) async {
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .doc(messageID)
        .update({
      "message": newMessage,
    });
  }

  // Xóa tin nhắn (Delete)
  Future<void> deleteMess(String chatRoomID, messageID) async {
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .doc(messageID)
        .delete();
  }
}
