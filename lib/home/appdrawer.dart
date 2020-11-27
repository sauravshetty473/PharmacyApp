import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/cartshell.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/home/profile/profileshell.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/buttons.dart';
import 'package:shavishank/shared/getdata.dart';



class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {



  @override
  Widget build (BuildContext context) {
  //  final user = Provider.of<CustomUser>(context);                                    //getting info of user
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width/12,
                  child: Image(
                    image: AssetImage("assets/images/male.png"),
                  ),
                ),
              ),

              FlatButton(
                child: Text("Profile"),
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileShell()));
                 },
              ),

              Divider(
                height: 0,
                thickness: 1
              ),
              FlatButton(
                child: Text("Cart"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => CartShell()));
                },
              ),
              AppDrawerFlatButton(
                name: "My Orders",
                pushwidget: ProfilePage(),
              ),
              AppDrawerFlatButton(
                name: "My Wishist",
                pushwidget: ProfilePage(),
              ),
              AppDrawerFlatButton(
                name: "Notifications",
                pushwidget: ProfilePage(),
              ),
              Divider(
                  height: 0,
                  thickness: 1
              ),
              AppDrawerFlatButton(
                name: "Policy",
                pushwidget: ProfilePage(),
              ),
              FlatButton(
                child: Text("Log Out"),
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
        ),
      ),
    );}
}

