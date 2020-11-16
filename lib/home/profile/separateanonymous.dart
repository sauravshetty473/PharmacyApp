
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/login/register.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';


class SeparateAnon extends StatelessWidget {

  NamePage newpage;
  SeparateAnon({this.newpage});



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    bool temp;
    if(user!=null){
       temp = user.isperson;
    }
    else{
       temp = false;
    }



    return temp?ProfilePage(newpage: newpage,):Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(



         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text("Login with you registered email to create a profile",
               style: TextStyle(),


             ),
             FlatButton(
               child: Text("Login",
               style: TextStyle(color: Colors.blue,
               fontSize: 20),
               ),
               onPressed: (){
               FirebaseAuth.instance.signOut();
               Navigator.pop(context);
        },
      ),
           ],
         ),)
    );
  }
}



