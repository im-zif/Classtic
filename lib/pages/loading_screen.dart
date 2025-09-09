import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  //wait 3 seconds in loading screen
  void leaveLoadingScreen () async {
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, '/auth');
    });
  }

  //initial state
  @override
  void initState() {
    super.initState();
    leaveLoadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F13),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //classtic
            Text(
              'Classtic',
              style: TextStyle(
                fontSize: 32,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 30,),

            //spinner animation
            SpinKitWaveSpinner(
              size: 50,
              color: Colors.white,
              waveColor: Colors.white,
            )
          ],
        ),
      )
    );
  }
}
