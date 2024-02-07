import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyage_visage/screens/option_screen.dart';

void main() async {
  // Ensure Flutter binding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase before running the app
  await Firebase.initializeApp();
  
  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the theme for the entire app
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      
      // Specify the initial screen of the app
      home: OptionScreen(),
      
      // Disable the debug banner in the app
      debugShowCheckedModeBanner: false,
    );
  }
}
