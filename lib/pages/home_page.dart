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

  String about = 'Welcome to Classtic! I\'m Imtiaz Asif, and I’m developing this app as part of my journey as a Computer Science and Engineering student. My goal with Classtic is not just to create a useful tool for students, but also to challenge myself to learn and grow as a developer. The app is still in development, but I’m excited to keep improving it and adding new features as I gain more experience.';

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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Center(
                      child: Icon(
                        Icons.info_outline,
                        size: 65,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Text(
                      about,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: signUserOut,
                        icon: Icon(Icons.logout, color: Colors.white,),
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
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
