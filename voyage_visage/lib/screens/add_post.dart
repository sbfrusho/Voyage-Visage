import 'dart:io';

import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? image;
  TextEditingController titelController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                ),
                SizedBox(height: 30,),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titelController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter post title',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLength: 5,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter post Description',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
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
