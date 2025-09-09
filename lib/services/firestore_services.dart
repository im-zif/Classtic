import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{

  //get collection of announcements
  final CollectionReference announcements = FirebaseFirestore.instance.collection('announcements');

  //Create: add new announcement
  Future<void> addAnnouncement (String announcement) {
    return announcements.add({
      'announcement': announcement,
      'timestamp': Timestamp.now()
    });
  }

  //READ: get announcement from database
  Stream<QuerySnapshot> getAnnouncementsStream(){
    final announcementsStream = announcements.orderBy('timestamp', descending: true).snapshots();
    return announcementsStream;
  }

  //UPDATE: update announcements given a doc id
  Future<void> updateAnnouncement(String docID, String newAnnouncement){
    return announcements.doc(docID).update({
      'announcement': newAnnouncement,
      'timestamp': Timestamp.now()
    });
  }

  //DELETE: delete announcements given a doc id
  Future<void> deleteAnnouncement(String docID){
    return announcements.doc(docID).delete();
  }



  //get collection of assignment tiles
  final CollectionReference assignmentTiles = FirebaseFirestore.instance.collection('assignmentTiles');

  //Create: add new assignmentTile
  Future<void> addAssignmentTile (String subject, String description) {
    return assignmentTiles.add({
      'subject': subject,
      'description' : description,
      'timestamp': Timestamp.now(),
      'ownerId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  //READ: get assignment tiles from database
  Stream<QuerySnapshot> getAssignmentTilesStream(){
    final assignmentTilesStream = assignmentTiles.orderBy('timestamp', descending: true).snapshots();
    return assignmentTilesStream;
  }

  //DELETE: delete assignmentTile given a doc id
  Future<void> deleteAssignmentTile(String docID){
    return assignmentTiles.doc(docID).delete();
  }

}