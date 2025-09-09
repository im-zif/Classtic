import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classtic/utils/assignment_tile.dart';

import '../services/firestore_services.dart';

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  File? _selectedPDF;
  final FirestoreService firestoreService = FirestoreService();

  // Select PDF
  void selectPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPDF = File(result.files.single.path!);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF Selected: ${result.files.single.name}")),
      );
    }
  }

  // Upload PDF
  void uploadPDF(docID) async {
    if (_selectedPDF == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a PDF first")),
      );
      return;
    }

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("assignments/$uid/$fileName.pdf")
          .putFile(_selectedPDF!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Store it in Firestore
      await firestoreService.assignmentTiles.doc(docID).update({
        "fileUrl": downloadUrl,
        "fileName": "$fileName.pdf",
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PDF uploaded successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    }
  }

  // Show dialog to add assignment
  void showAddAssignmentDialog() {
    final subjectController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C333D),
          title: const Text(
            "New Assignment",
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView( // ✅ fixes layout issues
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: subjectController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter subject",
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descController,
                    minLines: 1,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter description",
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: (){
                firestoreService.addAssignmentTile(subjectController.text, descController.text);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  // Remove assignment tile
  void removeAssignment(docID) {
    setState(() {
      firestoreService.deleteAssignmentTile(docID);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F13),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Assignments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: showAddAssignmentDialog,
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: firestoreService.getAssignmentTilesStream(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List assignmentTilesList = snapshot.data!.docs;
                    if (assignmentTilesList.isEmpty) {
                      //handle empty collection
                      return Center(
                        child: Text(
                          "No assignments",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: assignmentTilesList.length,
                      itemBuilder: (context, index){
                        DocumentSnapshot document = assignmentTilesList[index];
                        String docID = document.id;

                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        String subject = data['subject'];
                        String description = data['description'];

                        return AssignmentTile(
                          subject: subject,
                          description: description,
                          pdfUrl: data['fileUrl'],
                          selectPDF: selectPDF,
                          uploadPDF: () => uploadPDF(docID),
                          remove: () => removeAssignment(docID),
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: Text(
                        "No assignments",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
