import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const TextBox({super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(left: 15, right: 15,bottom: 15),
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.white70),
              ),

              IconButton(onPressed: onPressed,
                  icon: Icon(Icons.edit,
                    color: Colors.white,

                  )),
            ],
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
        ],

      ),
    );
  }
}