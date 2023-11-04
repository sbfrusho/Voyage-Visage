import 'package:flutter/material.dart';
import 'package:voyage_visage/screens/add_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("New Blogs"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              child: Icon(Icons.add),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPost()));
              },
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          children: [
            Text("Here we go"),
          ],
        ),
      ),
    );
  }
}
