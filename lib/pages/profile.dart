import 'package:classtic/utils/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F13),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('User').doc(user!.email).snapshots(),
        builder: (context, snapshot){
          //get user data
          if(snapshot.hasData){
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
              children: [
                //profile photo
                Center(
                  child: CircleAvatar(
                    radius: 70,
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
                )

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
