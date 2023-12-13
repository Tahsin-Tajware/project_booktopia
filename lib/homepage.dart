import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //image: DecorationImage(
         // image: AssetImage('assets/sign.png'),
          //fit: BoxFit.cover,
        //),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [


          ],
        ),
      ),
    );
  }
}
