// ignore_for_file: prefer_const_constructors, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:note_app/check_valid/valid.dart';
import 'package:note_app/connection/links_api.dart';
import 'package:note_app/connection/sql.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/screens/login.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  // ignore: prefer_final_fields
  var snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );
  SQL _sql = SQL();
  bool isLoading = false;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();

  SignUp() async {
    final isvalid = _globalKey.currentState?.validate();
    if (isvalid == true) {
      isLoading = true;
      setState(() {});
      var response = await _sql.postRequset(linkSignUp, {
        "username": _username.text,
        "email": _email.text,
        "password": _password.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        print("signup faild");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("Enter valid things")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Focus",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 137, 139, 3),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/icon_note.png",
                        width: 200,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                        
                          validator: (value) {
                            return validInput(value!, 3, 20);
                          },
                          style: TextStyle(color: Colors.white),
                          controller: _username,
                          decoration: InputDecoration(
                            labelText: 'Enter your name',
                            focusColor: Colors.amber,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 179, 162, 11))),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 162, 11)),
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                      
                          validator: (value) {
                            return validInput(value!, 5, 40);
                          },
                          style: TextStyle(color: Colors.white),
                          controller: _email,
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                            focusColor: Colors.amber,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 179, 162, 11))),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 162, 11)),
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          
                          validator: (value) {
                            return validInput(value!, 3, 10);
                          },
                          style: TextStyle(color: Colors.white),
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: 'Enter your password',
                            focusColor: Colors.amber,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 179, 162, 11))),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 162, 11)),
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: StadiumBorder(),
                        color: Color.fromARGB(255, 179, 162, 11),
                        onPressed: () async {
                          await SignUp();
                        },
                        child: Text(
                          "Sign Up ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Already have account ?? ",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => Login()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
