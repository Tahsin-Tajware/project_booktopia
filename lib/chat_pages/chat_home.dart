import 'package:booktopia/service/chat_service.dart';
import 'package:flutter/material.dart';
import '../elements/my_drawer.dart';
import '../elements/user_tile.dart';
import '../login/firebase_auth_services.dart';
import '../login/login.dart';
import '../view/main_tab/menubar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_page.dart';

class ChatHome extends StatefulWidget {
  ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final ChatService _chatService = ChatService();
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        title: Text(
          "        Chat       ",
          style: TextStyle(
              fontSize: 28,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.end,
        ),
        // backgroundColor: Colors.transparent,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) =>
              _buildUserListItem(userData, context)).toList(),

        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData,
      BuildContext context) {
    if (userData["email"] != _firebaseAuthServices.getCurrentUser() !.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                ChatPage(
                  receiverEmail: userData["email"],
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
