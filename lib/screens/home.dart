// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:note_app/component/container_note.dart';
import 'package:note_app/connection/links_api.dart';
import 'package:note_app/connection/sql.dart';
import 'package:note_app/main.dart';
import 'package:note_app/screens/add.dart';
import 'package:note_app/screens/edit.dart';
import 'package:note_app/screens/login.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SQL {
  bool onfav = false;
  getNotes() async {
    var response =
        await postRequset(linkview, {"id": sharedpref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.black, actions: [
        IconButton(
            onPressed: () {
              sharedpref.clear();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Login()));
            },
            icon: Icon(Icons.exit_to_app_outlined))
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff855447),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNotes()));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  "My Notes",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("All"), Icon(Icons.task_outlined)],
                        )),
                  ],
                ),
              ],
            ),
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail')
                      return Center(
                        child: Text(
                          "No Notes Found",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 150,
                            height: 300,
                            child: NoteContainer(
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => EditNotes(
                                              notes: snapshot.data['data'][i],
                                            )));
                              },
                              title:
                                  "${snapshot.data['data'][i]['notes_title']}",
                              content:
                                  "${snapshot.data['data'][i]['notes_content']}",
                              onDelete: () async {
                                var response = await postRequset(linkdelete, {
                                  'notes_id': snapshot.data['data'][i]
                                          ['notes_id']
                                      .toString(),
                                });
                                if (response['status'] == "success") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomeScreen()));
                                }
                              },
                            ),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: Text("loading.."),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
