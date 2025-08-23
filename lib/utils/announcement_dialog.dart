import 'package:classtic/services/firestore_services.dart';
import 'package:flutter/material.dart';

class AnnouncementDialog extends StatelessWidget {
  String? docID;
  final TextEditingController controller;
  final FirestoreService firestoreService = FirestoreService();

  AnnouncementDialog({super.key, required this.controller, this.docID});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      backgroundColor: Color(0xFF2C333D),
      content: Container(
        height: 180,
        child: Column(
          children: [
            TextField(
              minLines: 5,
              maxLines: 5,
              controller: controller,
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add new announcement',
                hintStyle: TextStyle(
                  color: Colors.grey[600]
                )
              ),
            ),
            Expanded(
              child: IconButton(
                color: Colors.white,
                onPressed: (){
                  if(docID == null){
                    firestoreService.addAnnouncement(controller.text);
                  }else{
                    firestoreService.updateAnnouncement(docID!, controller.text);
                  }
                  controller.clear();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
