import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyage_visage/screens/home_screen.dart';
import 'package:voyage_visage/screens/login_screen.dart';
import 'package:voyage_visage/screens/option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/blog-logo.png'),
              height: MediaQuery.of(context).size.height*.3,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              'Blog',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.amber,
                  fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
    else{
      Timer(Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OptionScreen()));
      });
    }
  }
}
