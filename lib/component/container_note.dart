// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/screens/edit.dart';
import 'package:share_plus/share_plus.dart';

class NoteContainer extends StatefulWidget {
  final void Function()? ontap;
  final void Function()? onDelete;
  final String title;
  final String content;
  const NoteContainer(
      {super.key,
      required this.ontap,
      required this.title,
      required this.content,
      required this.onDelete});

  @override
  State<NoteContainer> createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  bool onfav = false;
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: widget.ontap,
          child: Row(
            children: [
              Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                    color: Color(0xFFf7d44c),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.title}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _timeOfDay.format(context).toString(),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black),

                              // Text
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text("${widget.content}"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 100,
                height: 300,
                decoration: BoxDecoration(
                    color: Color(0xFFe67b56),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: _showTimePicker,
                            icon: Icon(
                              Icons.timer_outlined,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: widget.onDelete,
                            icon: Icon(
                              Icons.delete_outlined,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              Share.share("My task Title is ${widget.title} And I wanna   ${widget.content} At ${_timeOfDay.format(context)}");
                            },
                            icon: Icon(
                              Icons.bluetooth_outlined,
                              size: 30,
                            )),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
