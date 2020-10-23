import 'package:flutter/material.dart';
import 'package:shavishank/services/auth.dart';
import 'package:shavishank/shared/constants.dart';
import 'package:shavishank/shared/loadingscreen.dart';

class SignIn extends StatefulWidget {
  final Function toggleView ;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth  = AuthService();             //need for signIn purpose
  final _formkey = GlobalKey<FormState>();                // to validate

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;




  @override
  Widget build(BuildContext context) {
  return loading?Loading():Scaffold(
    backgroundColor: Colors.brown[100],
    appBar: AppBar(title: Text("Sign in to Shavishank"), elevation: 0.0, backgroundColor: Colors.brown[200],
      actions: [
      FlatButton(
        child: Text("Register"),
        onPressed: widget.toggleView,
      )
    ],

    ),
    body:  Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50 ,vertical: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: idHintText("Enter your email"),
                validator: (val)=> val.isEmpty? "Enter an email":null,
                onChanged: (value){
                  setState(() {
                    email = value;
                  });

                },
              ),

              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "password"),          //copy all the content in the predefined constant and add my own hintText
                validator: (val)=> val.length<6?"Enter at least a 6 character password":null,
                obscureText: true,
                onChanged: (value){
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20,),

              RaisedButton(
                color: Colors.grey[700],
                child: Text("Sign In", style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_formkey.currentState.validate())            //true when both helper strings return null
                      {
                        setState(() {
                          loading =true;
                        });

                        dynamic result =await _auth.signInWithEmailPassword(email, password);
                        if(result==null)
                        {
                          setState(() {
                          error ="password and email do not match";
                          loading =false;
                      });
                    }
                  }
                },
              ),

              SizedBox(
                child: Text(error),
              )
            ],
          ),
        )
      ),
    )
  );
}}
