import 'package:classtic/services/auth_services.dart';
import 'package:classtic/utils/my_button.dart';
import 'package:classtic/utils/square_tile.dart';
import 'package:classtic/utils/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final Function()? onTap;
  const WelcomePage({super.key, required this.onTap});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //media query for responsive size
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    //sign user in method
    void signUserIn() async{

      //show loading
      showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator());
        }
      );

      //invalid credentials message popup
      void wrongCredentials(){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.deepPurple,
                title: Center(
                  child: Text(
                    'Invalid Credentials!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }
        );
      }

      //try sign in
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        //pop loading
        Navigator.of(context, rootNavigator: true).pop();
      } on FirebaseAuthException catch (e) {
        //pop loading
        Navigator.pop(context);

        //wrong credentials
        wrongCredentials();
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF0D0F13),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.02),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //Classtic
                Text(
                  'Classtic',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: height*0.02,),

                //Welcome
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5
                  ),
                ),
                SizedBox(height: height*0.02,),

                //Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                //Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                SizedBox(height: height*0.02,),

                //Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                //Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                SizedBox(height: height*0.005,),

                //Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.05,),

                //Sign In button
                MyButton(
                  buttonText: 'Sign In',
                  onTap: signUserIn,
                ),

                //Or continue with
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        height: height*0.1,
                        color: Colors.deepPurple[900],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        height: height*0.1,
                        color: Colors.deepPurple[900],
                      ),
                    ),
                  ],
                ),

                //Google square tile
                SquareTile(
                  onTap: () => AuthService().signInWithGoogle(),
                  imagePath: 'images/google.png',
                ),
                SizedBox(height: height * 0.15),

                //Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            color: Colors.lightBlueAccent
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
