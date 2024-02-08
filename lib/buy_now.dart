import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buy_now_page extends StatefulWidget {
  const buy_now_page({super.key});

  @override
  State<buy_now_page> createState() => _buy_now_pageState();
}

class _buy_now_pageState extends State<buy_now_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: const Text(
          "Buy Now Page",
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.w900),
          textAlign: TextAlign.end,
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Navigate back or perform any desired action
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
    body: Container(
      color: Theme.of(context).colorScheme.primary,
    ),
    );
  }
}
