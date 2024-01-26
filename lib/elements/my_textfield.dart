import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: false,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent.shade700),
          ),
          fillColor: Colors.black54,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.lightBlue.shade100),
        ),
      ),
    );
  }
}
