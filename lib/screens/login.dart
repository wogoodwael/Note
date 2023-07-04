// ignore_for_file: prefer_final_fields, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/connection/links_api.dart';
import 'package:note_app/main.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/screens/sign.dart';
import '../check_valid/valid.dart';
import '../connection/sql.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SQL _sql = SQL();
  bool isLoading = false;
  GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  login() async {
    if (_globalKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var resonponse = await _sql.postRequset(linkLogin, {
        "email": _email.text,
        "password": _password.text,
      });
      isLoading = false;
      setState(() {});
      if (resonponse['status'] == "success") {
        sharedpref.setString("id", resonponse['data']['id'].toString());
        sharedpref.setString("username", resonponse['data']['username']);
        sharedpref.setString("email", resonponse['data']['email']);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text("Not found ")));
      }
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
                          child: Column(children: [
                            Image.asset(
                              "images/icon_note.png",
                              width: 200,
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
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 179, 162, 11))),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 179, 162, 11)),
                                      borderRadius: BorderRadius.circular(20)),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
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
                                          color: Color.fromARGB(
                                              255, 179, 162, 11))),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 179, 162, 11)),
                                      borderRadius: BorderRadius.circular(20)),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
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
                                await login();
                              },
                              child: Text(
                                "Go",
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
                                  "You Don’t have account ?? ",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                InkWell(
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignScreen()));
                                  },
                                ),
                              ],
                            )
                          ]),
                        )))));
  }
}
