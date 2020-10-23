import 'package:flutter/material.dart';
import 'package:shavishank/services/auth.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text("Home Screen"), elevation: 0.0, backgroundColor: Colors.grey[500],
      actions:<Widget> [
        FlatButton.icon(icon: Icon(Icons.person) ,label: Text("log out"),
        onPressed: () async{                    //async so that you do not freeze the whole app just because of this
          _auth.signOut();
        },
        )

        ],
      ),


    );
  }
}
