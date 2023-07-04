// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app/connection/links_api.dart';
import 'package:note_app/main.dart';
import 'package:note_app/screens/home.dart';

import '../check_valid/valid.dart';
import '../connection/sql.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with SQL {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  bool isLoading = false;

  addNotes() async {
    if (_globalKey.currentState!.validate()) {
      isLoading = true;
      setState(() {
        
      });
      var response = await postRequset(linkadd, {
        "notes_title": title.text,
        "notes_content": content.text,
        "notes_users": sharedpref.getString("id"),
      });
          isLoading =false;
      setState(() {
        
      });
      if (response['status'] == "success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          :SafeArea(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  return validInput(value!, 3, 20);
                },
                controller: title,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Title',
                  focusColor: Colors.amber,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 179, 162, 11))),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 179, 162, 11)),
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  return validInput(value!, 3, 50);
                },
                controller: content,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter The content',
                  focusColor: Colors.amber,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 179, 162, 11))),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 179, 162, 11)),
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: StadiumBorder(),
                color: Color.fromARGB(255, 179, 162, 11),
                onPressed: () async {
                  await addNotes();
                },
                child: Text(
                  "Add ",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
