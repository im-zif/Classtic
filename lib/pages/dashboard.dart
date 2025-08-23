import 'package:classtic/utils/announcement_dialog.dart';
import 'package:classtic/utils/announcement_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classtic/services/firestore_services.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final controller = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  //Add announcement method
  void addNewAnnouncement(){
    //show dialog box
    showDialog(context: context, builder: (context){
      return AnnouncementDialog(
        controller: controller,
      );
    });
  }
  
  //Announcements list
  List announcements = [
    'No announcements for now but i will add more later'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Announcements',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              IconButton(
                onPressed: addNewAnnouncement,
                icon: Icon(Icons.add),
              )
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getAnnouncementsStream(),
              builder: (context, snapshot){
                //if we have data, get all the docs
                if(snapshot.hasData){
                  List announcementsList = snapshot.data!.docs;

                  if (announcementsList.isEmpty) {
                    //handle empty collection
                    return ListView(
                      children: [
                        AnnouncementTile(
                          announcement: 'No announcements',
                          timestamp: 'Add announcement to show',
                        ),
                      ],
                    );
                  }

                  //display as a list
                  return ListView.builder(
                    itemCount: announcementsList.length,
                    itemBuilder: (context, index){
                      //get each individual doc
                      DocumentSnapshot document = announcementsList[index];
                      String docID = document.id;

                      //get announcement from doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      String announcementText = data['announcement'];
                      Timestamp timestamp = data['timestamp'];
                      DateTime dateTime = timestamp.toDate();
                      String announcementTime = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);

                      //display as an announcement tile
                      return AnnouncementTile(
                        announcement: announcementText,
                        timestamp: announcementTime,
                      );
                    }
                  );
                }
                //if there is no data
                else{
                  return Center(
                    child: Text(
                      "No announcements",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
