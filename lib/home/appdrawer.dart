import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/cartshell.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/home/profile/profileshell.dart';
import 'package:shavishank/home/profile/vieworder.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/buttons.dart';
import 'package:shavishank/shared/csoon.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              minWidth: 0,
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
              minWidth: 0,
              child: Text("Cart"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CartShell()));
              },
            ),
            AppDrawerFlatButton(
              name: "My Orders",
              pushwidget: ViewOrders(),
            ),
            AppDrawerFlatButton(
              name: "My Wishist",
              pushwidget: ComingSoon("Wishlist"),
            ),
            AppDrawerFlatButton(
              name: "Notifications",
              pushwidget: ComingSoon("Notifications"),
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
              minWidth: 0,
              child: Text("Log Out"),
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
    );}
}

