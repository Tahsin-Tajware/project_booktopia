import 'package:booktopia/login/firebase_auth_services.dart';
import 'package:booktopia/service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../elements/chat_bubble.dart';
import '../elements/my_textfield.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  // Widget _buildMessageList() {
  //   String senderID = _firebaseAuthServices.getCurrentUser()!.uid;
  //   return StreamBuilder(
  //     stream: _chatService.getMessages(receiverID, senderID),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Text("Error");
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text("Loading...");
  //       }
  //
  //       var messages = snapshot.data?.docs;
  //       if (messages == null || messages.isEmpty) {
  //         return const Text("No messages available");
  //       }
  //
  //       return ListView(
  //         children: messages.map((doc) => _buildMessageItem(doc)).toList(),
  //       );
  //     },
  //   );
  // }

  Widget _buildMessageList() {
    String senderID = _firebaseAuthServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderID'] == _firebaseAuthServices.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message:data["message"], isCurrentUser: isCurrentUser,)
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}