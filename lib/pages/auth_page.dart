import 'package:classtic/pages/home_page.dart';
import 'package:classtic/pages/welcom_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user logged in
          if(snapshot.hasData){
            return HomePage();
          }

          //user NOT logged in
          else{
            return WelcomeOrRegisterPage();
          }
        },
      ),
    );
  }
}
