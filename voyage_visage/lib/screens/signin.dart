import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:voyage_visage/components/round_button.dart';
import 'package:voyage_visage/screens/login_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool showSpinner = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Voyage visage"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: textEditingControllerEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                email = value;
                              },
                              validator: (value) {
                                return value!.isEmpty ? 'Enter email' : null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: textEditingControllerPassword,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {
                                password = value;
                              },
                              validator: (value) {
                                return value!.isEmpty ? 'Enter password' : null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RoundButton(
                                title: 'Register',
                                onPress: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final user = await _auth
                                          .createUserWithEmailAndPassword(
                                              email: email.toString().trim(),
                                              password:
                                                  password.toString().trim());
                                      if (user != null) {
                                        print('Success');
                                        toastMessages(
                                            "User seccessfully registered");
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                      toastMessages(e.toString());
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  }
                                })
                          ],
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void toastMessages(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
