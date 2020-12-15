import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:shavishank/home/profile/vieworder.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/loadingscreen.dart';
import 'package:shavishank/specialaccess/assigntoboy.dart';




class OrderAndDelivery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: StreamBuilder(

        stream: DatabaseService().Orderdata.snapshots(),


        builder: (context, snapshot){
          if(snapshot.data==null){
            return Loading();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor:  Color.fromARGB(255,78,100,123),
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(child : Text("Pending Orders")),
                  Tab(child : Text("Out for Delivery")),
                  Tab(child : Text("Completed Orders")),
                ],
              ),
              title: Text("Customer Orders"),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                    child: Column(
                        children: (snapshot.data as QuerySnapshot).docs.map((e) {
                          return e.get("completed")=="false"&&e.get("deliveryout")=="false"?FocusedMenuHolder(
                              animateMenuItems: false,
                              menuItems: [
                                FocusedMenuItem(title: Text("Assign to self"), onPressed: () async {
                                  await DatabaseService().Orderdata.doc(e.id).update({
                                    "self" : "self",
                                    "deliveryout" : "true"
                                  });
                                  Fluttertoast.showToast(msg: "Order out for delivery");
                                }),
                                FocusedMenuItem(title: Text("Assign to a delivery boy"), onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => AssignToBoy(id: e.id,)));
                                })
                              ],
                              child: NewOrderTable(e , out_for_delivery: "",)):SizedBox();    //if not completed and also not out for delivery
                        }).toList()
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                    child: Column(
                        children: (snapshot.data as QuerySnapshot).docs.map((e) {
                          return e.get("completed")=="false"&&e.get("deliveryout")=="true"?FocusedMenuHolder(
                              menuItems: [
                                FocusedMenuItem(title: Text( "Retract"),
                                    onPressed: () async {
                                        await e.reference.update({
                                          "deliveryout" : "false",
                                          "self" : ""
                                        });
                                    }
                                )
                              ],
                              child: NewOrderTable(e , out_for_delivery: "",)):SizedBox();
                        }).toList()
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                    child: Column(
                        children: (snapshot.data as QuerySnapshot).docs.map((e) {
                          return e.get("completed")=="true"?NewOrderTable(e , out_for_delivery: "",):SizedBox();
                        }).toList()
                    ),
                  ),
                ),

              ],
            ),
          );
        }
      ),
    );
  }
}



