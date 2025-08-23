import 'package:classtic/pages/assignments.dart';
import 'package:classtic/pages/dashboard.dart';
import 'package:classtic/pages/profile.dart';
import 'package:classtic/utils/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //selected index to control bottom navigation bar
  int _selectedIndex = 0;

  //method to change selected index
  void navigateBottomNavBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages
  final List<Widget> _pages = [

    //dashboard
    Dashboard(),

    //assignments
    Assignments(),

    //profile
    Profile()
  ];

  //sign user out method
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F13),

      //Drawer
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

      //Appbar
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0F13),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      //Body
      body: _pages[_selectedIndex],

      //Bottom navigation bar
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomNavBar(index),
      ),
    );
  }
}
