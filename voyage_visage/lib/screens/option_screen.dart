//this is a login or register option screen
//user selects one of them to navigate to the home page
//if user has an account selects login
//if new user is coming then selects register option


import 'package:flutter/material.dart';
import 'package:voyage_visage/components/round_button.dart';
import 'package:voyage_visage/screens/login_screen.dart';
import 'package:voyage_visage/screens/signin.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loginpage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //login button for login form
                RoundButton(
                    title: "Login",
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }),
                SizedBox(
                  height: 30,
                ),

                //register button for register form
                RoundButton(
                  title: "Register",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
