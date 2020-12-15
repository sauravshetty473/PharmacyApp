import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shavishank/services/database.dart';



class AssignToBoy extends StatefulWidget {
  String id;
  AssignToBoy({this.id});

  @override
  _AssignToBoyState createState() => _AssignToBoyState();
}

class _AssignToBoyState extends State<AssignToBoy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Availability"),
      backgroundColor: Color.fromARGB(255,78,100,123),),
      body: StreamBuilder(
        stream: DatabaseService().DeliveryBoys.snapshots(),
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Center(child: Text("No available delivery boys"),);
          }
          if(snapshot.data.docs.length == 0){
            return Center(child: Text("No available delivery boys"),);
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (snapshot.data as QuerySnapshot).docs.map((e) => FlatButton(

                onPressed: () async {
                  await DatabaseService().Orderdata.doc(widget.id).update({
                    "self" : e.id,
                    "deliveryout" : "true"
                  });
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Order out for delivery");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.get("name"), style: TextStyle(fontSize: 20),),
                      Text(e.id),
                      Divider(thickness: 1, height: 30,)
                    ],
                  ),
                ),
              ),).toList(),
            ),
          );
        },
      ),
    );
  }
}
