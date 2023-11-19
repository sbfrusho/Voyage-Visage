import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:voyage_visage/components/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:voyage_visage/screens/login_screen.dart';


class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  bool showSpinner = false;
  // ignore: deprecated_member_use
  final postRef = FirebaseDatabase.instance.reference().child("Posts");
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;


  File? image;
  final picker = ImagePicker();
  TextEditingController titelController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        image = File(pickedFile.path);
      }
      else{
        print('No image selected');
      }
    }); 
  }

  Future getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null){
        image = File(pickedFile.path);
      }
      else{
        print('No image captured');
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImageCamera();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
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
                  InkWell(
                    onTap: () {
                      dialog(context);
                    },
                    child: Center(
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          keyboardType: TextInputType.text,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter post Description',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundButton(title: "Upload", onPress: ()async {
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      int date = DateTime.now().microsecondsSinceEpoch;
                      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/VOYAGE_VISAGE$date');
                      UploadTask uploadTask = ref.putFile(image!.absolute);
                      await Future.value(uploadTask);
                      var newUrl =await ref.getDownloadURL();
                      final User? user = _auth.currentUser;
                      postRef.child('Post List').child(date.toString()).set({
                        'pId' : date.toString(),
                        'pImage' : newUrl.toString(),
                        'pTime' : date.toString(),
                        'pTitle' : titelController.text.toString(),
                        'pDescription' : descriptionController.text.toString(),
                        'UEmail' : user!.email.toString(),
                        'uId' : user.uid.toString(),
                        
                      }).then((value){
                        toastMessages('Post Published');
                        setState(() {
                      showSpinner = false;
                      Navigator.pop(context);

                    });
                      }).onError((error, stackTrace) {
                        toastMessages(error.toString());
                        setState(() {
                      showSpinner = false;

                    });
                      });
                    }
                    catch(e){
                      setState(() {
                      showSpinner = false;

                    });
                      toastMessages(e.toString());
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void toastMessages(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}



