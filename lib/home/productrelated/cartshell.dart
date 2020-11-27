import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/cart.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';

class CartShell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, snapshot){
        if(snapshot.data==null){
          return Loading();
        }

        if(snapshot.data[2]==null||!snapshot.data[2].isperson){
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

        return (snapshot.data[0].firstname==""||snapshot.data[0].pincode=="")?Scaffold(
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
                          builder: (context) => ProfilePage(newpage: snapshot.data[0] )));
                    },
                  ),
                ],
              ),)
        ):Cart(snapshot.data[0],snapshot.data[1]);
      },
      future: getAllCartData(context),
    );
  }
}


Future getAllCartData(BuildContext context) async{
  NamePage newclass = await getdata(context);
  final user = Provider.of<CustomUser>(context , listen: false);
  final list = await getCartData(user.uid);
  return [newclass,list,user];
}