//This is the main screen of the app
//It displays a list of blogs with a cover picture
//uploaded by different users
//this screen also has search bar

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyage_visage/screens/add_post.dart';
import 'package:voyage_visage/screens/login_screen.dart';
import 'package:voyage_visage/screens/read_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: deprecated_member_use

  final dbRef =
      FirebaseDatabase.instance.ref().child('Posts'); // database reference
  FirebaseAuth auth = FirebaseAuth.instance; // firebase authentication
  TextEditingController searchController =
      TextEditingController(); // search handler
  // TextEditingController searchControllerUserName = TextEditingController(); //
  String search = "";
  String userName = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          // backgroundColor: Colors.grey,
          appBar: AppBar(
            elevation: 0,
            title: Text("New Blogs"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              // a add(+) button is added to the app bar
              //when user clicks on the button a upload
              //screen appears with necessary fields
              InkWell(
                child: Icon(Icons.add),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPost()));
                },
              ),
              SizedBox(
                width: 20,
              ),

              //a signout button is also added to the app bar
              //when user clicks on the button it performs
              //an immediate log out function
              InkWell(
                onTap: () {
                  auth.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
                child: Icon(Icons.logout),
              )
            ],
          ),

          //this module contains the main screen of the app
          //it contains a list of blogs with cover picture
          //title and author name of the blog also appears

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
                  //search function module
                  TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        search = value;
                      });
                    },
                  ),
                  Expanded(
                    child: FirebaseAnimatedList(
                      query: dbRef.child('Post List'),
                      itemBuilder: (context, snapshot, animation, index) {
                        Map m = Map.from((snapshot.value ?? {}) as Map);
                        String tempTitle = m['pTitle'];
                        userName = m['UEmail'];
                        // print('$userName');
                        int atIndex = userName.indexOf('@');
                        // print('$atIndex');
                        String extractedUserName =
                            userName.substring(0, atIndex);
                        // print('$extractedUserName');

                        // print(tempTitle);
                        // print(search);
                        if (searchController.text.isEmpty) {
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
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: InkWell(
                                        child: Image.network(
                                          m['pImage'],
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          //when user clicks on the image
                                            //this module takes him to the read post 
                                            //screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ReadPost(
                                                title: m['pTitle'],
                                                description: m['pDescription'],
                                                imageUrl: m['pImage'],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        //when user clicks on the title
                                            //this module takes him to the read post 
                                            //screen
                                        child: TextButton(
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.blue),
                                              alignment: Alignment.topLeft),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReadPost(
                                                          title: m['pTitle'],
                                                          description:
                                                              m['pDescription'],
                                                          imageUrl: m['pImage'],
                                                        )));
                                          },
                                          child: Text(
                                            m['pTitle'],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 60, 106),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),

                                      //this module shows the name of the author
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Author: $extractedUserName',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 60, 106),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (tempTitle
                            .toLowerCase()
                            .contains(searchController.text.toString())) {
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
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
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
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.blue),
                                              alignment: Alignment.topLeft),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReadPost(
                                                          title: m['pTitle'],
                                                          description:
                                                              m['pDescription'],
                                                          imageUrl: m['pImage'],
                                                        )));
                                          },
                                          child: Text(
                                            m['pTitle'],
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 60, 106),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Author: $extractedUserName',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 60, 106),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
