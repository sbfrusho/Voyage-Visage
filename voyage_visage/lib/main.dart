import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyage_visage/screens/option_screen.dart';
import 'package:voyage_visage/screens/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

}