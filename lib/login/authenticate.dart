import 'package:flutter/material.dart';
import 'package:shavishank/login/register.dart';
import 'package:shavishank/login/signin.dart';



class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;

  void toggleview()
  {
    setState(() {
      signIn = signIn?false:true;    //Its a toggle hence this logic is enough
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child : signIn?SignIn( toggleview):Register( toggleview),
    );
  }
}
