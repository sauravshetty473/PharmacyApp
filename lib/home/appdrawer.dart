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
import 'package:shavishank/specialaccess/specialaccess.dart';



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
              pushwidget: ComingSoon("Policy"),
            ),
            FlatButton(
              minWidth: 0,
              child: Text("Log Out"),
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
            ),

            Divider(
                height: 0,
                thickness: 1
            ),
            Container(
              decoration : BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5)
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              margin: EdgeInsets.symmetric(vertical: 10),

              child: FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SpecialAccess()));
                },
                child: Text("Special Access",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red
                  ),),
              ),
            ),
            
          ],
        ),
      ),
    );}
}

