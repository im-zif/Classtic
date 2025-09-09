import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {

  final String category;
  final String content;
  void Function()? onPressed;

  MyTextBox({super.key, required this.category, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xFF2C333D),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  category,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.grey[600],
                ),
              )
            ],
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}
