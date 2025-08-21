import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  //sign user out method
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F13),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Color(0xFF2C333D),
          child: Column(
            children: [
              IconButton(
                onPressed: signUserOut,
                icon: Icon(Icons.logout, color: Colors.white,),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF0D0F13),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Text('Logged in!'),
      ),
    );
  }
}
