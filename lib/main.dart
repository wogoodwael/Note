import 'package:flutter/material.dart';
import 'package:note_app/screens/home.dart';
import 'package:note_app/screens/login.dart';
import 'package:note_app/screens/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _scaffoldkey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: _scaffoldkey,
        debugShowCheckedModeBanner: false,
        home: sharedpref.getString("id") == null ? Login() : HomeScreen());
  }
}
