import 'package:flutter/material.dart';
import 'package:shavishank/services/auth.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth  = AuthService();
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.brown[100],
    appBar: AppBar(title: Text("Sign in to Shavishank"), elevation: 0.0, backgroundColor: Colors.brown[200],),
    body:  Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50 ,vertical: 20),
        child: RaisedButton(
          child: Text("sign in anonymously"),
          onPressed: ()async{
            dynamic result =  await _auth.signInAnon();                                           //it will return user (object of User class) or Null if not successful;
            if(result==null)
              {
                print("error occurred");
              }
            else{
              print(result.uid);
            }
          },
        ),
      ),
    )
  );
}}
