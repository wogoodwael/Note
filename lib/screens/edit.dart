// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app/connection/links_api.dart';
import 'package:note_app/main.dart';
import 'package:note_app/screens/home.dart';

import '../check_valid/valid.dart';
import '../connection/sql.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with SQL {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  bool isLoading = false;

  editNotes() async {
    if (_globalKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequset(linkedit, {
        "notes_title": title.text,
        "notes_content": content.text,
        "notes_id": widget.notes['notes_id']
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {}
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 179, 162, 11)),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 179, 162, 11)),
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
                        await editNotes();
                      },
                      child: Text(
                        "Edit ",
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
