import 'package:classtic/services/auth_services.dart';
import 'package:classtic/utils/my_button.dart';
import 'package:classtic/utils/square_tile.dart';
import 'package:classtic/utils/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {

  final Function()? onTap;
  const RegistrationPage({super.key, required this.onTap});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    //media query for responsive size
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    //sign user up method
    void signUserUp() async{

      //show loading
      showDialog(
          context: context,
          builder: (context){
            return Center(child: CircularProgressIndicator());
          }
      );

      //password do not match message popup
      void showPasswordErrorMessage(){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                backgroundColor: Colors.deepPurple,
                title: Center(
                  child: Text(
                    'Passwords do not match',
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

      //invalid error message popup
      void showErrorMessage(String message) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ),
            );
          },
        );
      }

      //try sign up
      try{
        //check if password in confirmed
        if(passwordController.text == confirmPasswordController.text){
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text
          );
          //pop loading
          Navigator.pop(context);
        }
        else{
          //pop loading
          Navigator.pop(context);

          //show password error message
          showPasswordErrorMessage();
        }
      } on FirebaseAuthException catch (e) {

        //pop loading
        Navigator.pop(context);

        //show error message
        if (e.code == 'invalid-email') {
          showErrorMessage("The email address is not valid.");
        } else if (e.code == 'email-already-in-use') {
          showErrorMessage("This email is already registered.");
        } else if (e.code == 'weak-password') {
          showErrorMessage("Password should be at least 6 characters.");
        } else {
          showErrorMessage("Error: ${e.message}");
        }
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

                //Create account
                Text(
                  'Create an account',
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
                  hintText: 'Create new password',
                  obscureText: true,
                ),
                SizedBox(height: height*0.02,),

                //Confirm Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                //Confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm you password',
                  obscureText: true,
                ),
                SizedBox(height: height*0.05,),

                //Sign Up button
                MyButton(
                  buttonText: 'Sign Up',
                  onTap: signUserUp,
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
                SizedBox(height: height * 0.08),

                //Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      child: Text(
                        "Sign in",
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
