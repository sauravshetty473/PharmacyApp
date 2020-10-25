import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AppDrawer extends StatelessWidget {





  @override
  Widget build (BuildContext context) {
    Color blackColor = Colors.black.withOpacity(0.6);
  //  final user = Provider.of<User>(context);                                    //getting info of user
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            height: 150,
            child: DrawerHeader(
              child: GestureDetector(
                child: ListTile(
                  trailing: Icon(
                    Icons.chevron_right,
                    size: 28,
                  ),
                  subtitle: GestureDetector(
                    onTap: () {
                      //Get.to(Profile((){}));
                    },
                    child: Text(
                      'Edit profile',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blackColor),
                    ),
                  ),

                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                  //  builder: (context) => Profile(() {}),
                  ));
                },
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFB),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: blackColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.pop(
                context,
                //PageTransition(
                //  type: PageTransitionType.fade,
                //  child: Container(),
              //  ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_turned_in, color: blackColor),
            title: Text('My Orders',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
            //  Get.to(MyOrdersView());
            },
          ),
//          ListTile(
//            leading: Icon(Icons.assignment_return, color: blackColor),
//            title: Text('My Returns',
//                style: TextStyle(
//                    fontSize: 16,
//                    fontWeight: FontWeight.w600,
//                    color: blackColor)),
//            onTap: () {
//              Get.to(ReturnOrdersView());
//            },
//          ),
          ListTile(
            //trailing: Icon(
          //    Ionicons.ios_radio_button_on,
          //    color: Color(0xFFFB7C7A),
           //   size: 18,
            //),
            leading: Icon(Icons.notifications, color: blackColor),
            title: Text('Notifications',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
             // Get.to(NotificationsView());
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart, color: blackColor),
            title: Text('Shopping Cart',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
             /// Get.to(CartView());
            },
          ),
          ListTile(
            leading: Icon(Icons.business_center, color: blackColor),
            title: Text('Sell on App (Coming Soon)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: blackColor),
            title: Text('Legal',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
             // Get.to(LegalInfo());
            },
          ),
//          ListTile(
//            leading:
//            Icon(Icons.chat, color: blackColor),
//            title: Text('Chats',
//                style: TextStyle(
//                    fontSize: 16,
//                    fontWeight: FontWeight.w600,
//                    color: blackColor)),
//            onTap: () {
//              //Nav.route(context, UserSettings());
//            },
//          ),
          ListTile(
            leading: Icon(Icons.info, color: blackColor),
            title: Text('About',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
             // Get.to(AboutUs());
            },
          ),
          Spacer(),
          Spacer(),
          FlatButton(
            child: Text('Log out', style: TextStyle(color: Colors.blue),),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );}
}

