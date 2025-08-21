import 'package:classtic/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: GNav(
        activeColor: Colors.black,
        color: Colors.grey[500],
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabBorderRadius: 12,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
          GButton(
            icon: Icons.dashboard,
            text: 'Dashboard',
          ),
          GButton(
            icon: Icons.assignment,
            text: 'Assignments',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          )
        ],
      ),
    );
  }
}
