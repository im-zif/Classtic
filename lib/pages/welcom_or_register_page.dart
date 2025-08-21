import 'package:classtic/pages/registration_page.dart';
import 'package:classtic/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class WelcomeOrRegisterPage extends StatefulWidget {
  const WelcomeOrRegisterPage({super.key});

  @override
  State<WelcomeOrRegisterPage> createState() => _WelcomeOrRegisterPageState();
}

class _WelcomeOrRegisterPageState extends State<WelcomeOrRegisterPage> {

  //initially show login page
  bool showWelcomePage = true;

  //toggle between login and registration page
  void togglePages(){
    setState(() {
      showWelcomePage = !showWelcomePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showWelcomePage){
      return WelcomePage(
        onTap: togglePages,
      );
    }
    else{
      return RegistrationPage(
        onTap: togglePages,
      );
    }
  }
}
