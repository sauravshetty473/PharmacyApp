import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/cart.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/shared/getdata.dart';




class CartAnon extends StatelessWidget {
  final temp2;
  NamePage namePage;
  CartAnon(this.namePage,this.temp2);

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

    if(temp!=false){
      return (this.namePage.firstname==""||this.namePage.pincode=="")?Scaffold(
          appBar: AppBar(title: Text("Cart"),),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Complete your profile first to add products to your cart",
                  style: TextStyle(),
                ),
                FlatButton(
                  child: Text("Complete your Profile",
                    style: TextStyle(color: Colors.blue,
                        fontSize: 20),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfilePage(newpage: namePage )));
                  },
                ),
              ],
            ),)
      ):Cart(namePage,temp2);
    }
    else
      {
        return Scaffold(
            appBar: AppBar(title: Text("Cart"),),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login with registered email to add products to your cart",
                    style: TextStyle(),
                  ),
                  FlatButton(
                    child: Text("Login",
                      style: TextStyle(color: Colors.blue,
                          fontSize: 20),
                    ),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),)
        );
      }
  }
}
