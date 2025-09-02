import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classtic/utils/assignment_tile.dart';

class Assignments extends StatefulWidget {
  const Assignments({super.key});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  File? _selectedPDF;

  // Select PDF method
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

  // Upload PDF method
  void uploadPDF() async {
    if (_selectedPDF == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a PDF first")),
      );
      return;
    }

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload to Firebase Storage
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("assignments/$uid/$fileName.pdf")
          .putFile(_selectedPDF!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save metadata in Firestore
      await FirebaseFirestore.instance
          .collection("assignments")
          .doc(uid)
          .collection("userAssignments")
          .add({
        "fileName": "$fileName.pdf",
        "url": downloadUrl,
        "uploadedAt": FieldValue.serverTimestamp(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F13),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'Assignments',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            AssignmentTile(
              subject: 'subject',
              description: 'description',
              selectPDF: selectPDF,
              uploadPDF: uploadPDF,
            )
          ],
        ),
      ),
    );
  }
}
