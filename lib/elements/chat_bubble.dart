import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode
                ? Colors.deepOrangeAccent.shade400
                : Colors.greenAccent.shade400)
            : (isDarkMode
                ? Colors.grey.shade800
                : Colors.purpleAccent.shade700),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
              ? (isDarkMode ? Colors.blue.shade100 : Colors.black87)
              : (isDarkMode ? Colors.cyan.shade100 : Colors.black87),
        ),
      ),
    );
  }
}
