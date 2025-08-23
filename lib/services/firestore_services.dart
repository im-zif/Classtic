import 'package:cloud_firestore/cloud_firestore.dart';

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

  //READ: ger announcement from database
  Stream<QuerySnapshot> getAnnouncementsStream(){
    final announcementsSteam = announcements.orderBy('timestamp', descending: true).snapshots();
    return announcementsSteam;
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

}