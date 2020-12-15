import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/profile/vieworder.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/loadingscreen.dart';



class MyDelivery extends StatefulWidget {
  bool admin;
  MyDelivery({this.admin=false});
  @override
  _MyDeliveryState createState() => _MyDeliveryState();
}

class _MyDeliveryState extends State<MyDelivery> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return Scaffold(
      appBar: AppBar(title: Text("My Delivery"),
      elevation: 0,
      backgroundColor: Color.fromARGB(255,78,100,123),
      ),


      body: StreamBuilder(
        stream: DatabaseService().Orderdata.snapshots(),
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Loading();
          }
          if(snapshot.data.docs.length == 0){
            return Center(child: Text("No deliveries at present"),);
          }

          return SingleChildScrollView(
            child: Column(
              children: widget.admin?(snapshot.data as QuerySnapshot).docs.where((element) => element.get("self")=="self"&&element.get("completed") =="false"&&element.get("deliveryout")=="true").map((e) => NewOrderTable(e,out_for_delivery: "",genQR: e.get("code"),)).toList():
              (snapshot.data as QuerySnapshot).docs.where((element) {
                print(element.get("self"));
                return element.get("self")==user.emailid&&element.get("completed") =="false"&&element.get("deliveryout")=="true";
              }).map((e) => NewOrderTable(e, out_for_delivery: "",genQR: e.get("code"),)).toList(),
            ),
          );
        }
      ),
    );
  }
}



