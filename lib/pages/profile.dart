import 'package:classtic/utils/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> uploadProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        //Upload to Firebase Storage
        String filePath = 'profilePics/${user!.uid}.png';
        await FirebaseStorage.instance.ref(filePath).putFile(imageFile);

        //Get download URL
        String downloadURL = await FirebaseStorage.instance.ref(filePath).getDownloadURL();

        //Update Firestore user doc with image URL
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
          'profileImage': downloadURL,
        });

        setState(() {});
      } catch (e) {
        print("Error uploading profile image: $e");
      }
    }
  }



  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF2C333D),
        title: Text(
          'Edit $field',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            hintText: 'Enter new $field',
          ),
          onChanged: (value){
            newValue = value;
          },
          ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text('Save'),
          )
        ],
        ),
      );
    if(newValue.trim().isNotEmpty){
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        field: newValue,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F13),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
        builder: (context, snapshot){
          //get user data
          if(snapshot.hasData){
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
              children: [
                //profile photo
                Center(
                  child: InkWell(
                    onTap: uploadProfileImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: userData['profileImage'] != null
                          ? NetworkImage(userData['profileImage'])
                          : AssetImage('images/pfp.png') as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                //email
                Center(
                  child: Text(
                    user!.email!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                //role
                Center(
                  child: Text(
                    'Student',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                //personal info ui
                Text(
                  'User Information',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 18,),

                //username
                MyTextBox(
                  category: 'Name',
                  content: userData['username'],
                  onPressed: ()=> editField('username'),
                ),

              ],
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}
