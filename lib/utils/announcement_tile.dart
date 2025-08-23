import 'package:flutter/material.dart';

class AnnouncementTile extends StatelessWidget {

  final String announcement;
  final String timestamp;

  const AnnouncementTile({super.key, required this.announcement, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2C333D),
          border: BoxBorder.all(
            color: Color(0xFF2C333D)
          ),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      announcement,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timestamp,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 11
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
