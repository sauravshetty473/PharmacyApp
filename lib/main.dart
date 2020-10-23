import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shavishank/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();                                               //necessary step before using any Firebase product //best place to do this(debatable) //make main async and await
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper()
    );
}}
