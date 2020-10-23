import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/auth.dart';
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
    return StreamProvider<CustomUser>.value(                         //This stream looking for CustomUser and providing the info to all the widgets below it(mainly wrapper class)  //its actively listening
      value: AuthService().user,                                     //creating an instance of AuthService and using user getter or Stream which returns user(Custom)
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper()
      ),
    );
}}
