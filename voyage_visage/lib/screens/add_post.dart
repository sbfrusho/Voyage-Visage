import 'dart:io';

import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Upload'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: MediaQuery.of(context).size.width,
                    child: image != null
                        ? ClipRRect(
                              child: Image.file(
                              image!.absolute,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(0),
                            ),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera,
                              color: Colors.grey,
                            ),
                          ),
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
