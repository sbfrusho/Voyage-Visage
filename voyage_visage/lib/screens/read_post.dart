import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ReadPost extends StatefulWidget {
  const ReadPost({super.key});

  @override
  State<ReadPost> createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  final dbRef = FirebaseDatabase.instance.ref().child('Posts');
  
  Map m = {};


  void retrieve(){
    FirebaseAnimatedList(
      query: dbRef.child('Post List'),
      itemBuilder: (context, snapshot, animation, index) {
        m = Map.from((snapshot.value ?? {}) as Map);
        return Column();
      },
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: m['pTitle']),
      // body: Column(
      //   children: [
      //     Text(m['pDescription']),
      //   ],
      // ),
    );
  }
}