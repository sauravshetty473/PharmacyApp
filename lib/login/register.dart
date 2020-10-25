import 'package:flutter/material.dart';
import 'package:shavishank/services/auth.dart';
import 'package:shavishank/shared/constants.dart';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(

            children: [
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 0),
                  child: Row(
                    children: [Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(child: Center(child: Text("Already have an Account?" , style: TextStyle(fontSize: 20),))),
                          Expanded(child: Center(child: Text("or")),),
                          Expanded(
                            child: Center(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                color: Colors.blue,
                                child: Text("Skip Login" , style: TextStyle(color: Colors.white),),
                                onPressed: () async{
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =await _auth.signInAnon();
                                  if(result==null)
                                  {
                                    setState(() {
                                      print("an error occurred");
                                      loading =false;
                                    });
                                  }
                                  else{
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ), //child: Text("Already have an Account?" , style: TextStyle(fontSize: 20),),
                    ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Image(
                          image: AssetImage("assets/images/loginnew.png"),
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Container(
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
                                    _formkey.currentState.validate();
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
                                    _formkey.currentState.validate();
                                    password = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20,),

                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                color: Colors.grey[500],
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width*2/5,
                                    child: Center(child: Text("Login", style: TextStyle(color: Colors.white ,fontSize: 20),))),
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
                                    else
                                    {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                              ),
                              /*SizedBox(
                            child: Text(error),
                          )*/
                              FlatButton(
                                  child: Text("New user? Create Account", style: TextStyle(fontSize: 13 , color: Colors.blue[700]),),
                                  onPressed: widget.toggleView
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
