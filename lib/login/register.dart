import 'package:flutter/material.dart';
import 'package:shavishank/services/auth.dart';
import 'package:shavishank/shared/loadingscreen.dart';


class Register extends StatefulWidget {
  final Function toggleView ;
  Register(this.toggleView);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth  = AuthService();                //for register purpose
  final _formkey = GlobalKey<FormState>();                // to validate

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;


  @override
  Widget build(BuildContext context) {


    return loading?Loading():Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(title: Text("Register to Shavishank"), elevation: 0.0, backgroundColor: Colors.brown[200],
          actions: [
            FlatButton(
              child: Text("Sign In"),
              onPressed: widget.toggleView,
            )
          ],
        ),
        body:  Container(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50 ,vertical: 20),
              child: Form(
                key:_formkey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (val)=> val.isEmpty? "Enter an email":null,
                      onChanged: (value){
                        setState(() {
                          _formkey.currentState.validate();                     //this checks the validator condition
                          email = value;
                        });

                      },
                    ),

                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (val)=> val.length<6?"Enter at least a 6 character password":null,
                      obscureText: true,
                      onChanged: (value){
                        setState(() {
                          _formkey.currentState.validate();                     //this checks the validator condition
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),

                    RaisedButton(
                      color: Colors.grey[700],
                      child: Text("Register", style: TextStyle(color: Colors.white),),
                      onPressed: () async{
                        if(_formkey.currentState.validate())            //true when both helper strings return null
                          {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =await _auth.registerWithEmailPassword(email, password);
                            if(result==null)
                              {

                                setState(() {
                                  error ="enter a valid email";
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
  }
}
