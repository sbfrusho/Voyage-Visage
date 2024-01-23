import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voyage_visage/components/round_button.dart';
import 'package:voyage_visage/screens/add_post.dart';
import 'package:voyage_visage/screens/read_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: deprecated_member_use

  final dbRef = FirebaseDatabase.instance.ref().child('Posts');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey,
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/2.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.75), BlendMode.dstATop),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FirebaseAnimatedList(
                    query: dbRef.child('Post List'),
                    itemBuilder: (context, snapshot, animation, index) {
                      Map m = Map.from((snapshot.value ?? {}) as Map);
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Image.network(
                                    m['pImage'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blue),
                                          alignment: Alignment.topLeft),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ReadPost(
                                                      title: m['pTitle'],
                                                      description:
                                                          m['pDescription'],
                                                      imageUrl: m['pImage'],
                                                    )));
                                      },
                                      child: Text(
                                        m['pTitle'],
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 7, 60, 106),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        Text("Clicked");
                                        Fluttertoast.showToast(
                                            msg: 'Hello, World!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      icon: Icon(Icons.delete),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        Text("Clicked");
                                        Fluttertoast.showToast(
                                            msg: 'Hello, World!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      icon: Icon(Icons.edit),
                                      alignment: Alignment.topRight,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
