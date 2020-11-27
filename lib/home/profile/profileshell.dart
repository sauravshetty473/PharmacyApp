
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/login/register.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';


class ProfileShell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context , snapshot){
        if(snapshot.data==null){
          return Loading();
        }
        if(snapshot.data[1] == null||!snapshot.data[1].isperson){
          return Scaffold(
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
                ),
              ),
          );
        }

        return ProfilePage(newpage: snapshot.data[0],);
      },
      future: getAllProfileData(context),
    );
  }
}





Future getAllProfileData(BuildContext context) async{
  NamePage newclass = await getdata(context);
  final user =await Provider.of<CustomUser>(context , listen: false);
  return [newclass,user];
}


