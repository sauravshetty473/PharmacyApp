import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/shared/buttons.dart';



class AppDrawer extends StatelessWidget {



  @override
  Widget build (BuildContext context) {
  //  final user = Provider.of<User>(context);                                    //getting info of user
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

              AppDrawerFlatButton(
                name: "Profile",
                pushwidget: ProfilePage(),
              ),
              Divider(
                height: 0,
                thickness: 1
              ),
              AppDrawerFlatButton(
                name: "All Categories",
                pushwidget: ProfilePage(),
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




            ],
          ),
        ),
      ),
    );}
}

