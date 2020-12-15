import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shavishank/specialaccess/assigndelivery.dart';
import 'package:shavishank/specialaccess/inspectitem.dart';
import 'package:shavishank/specialaccess/mydelivery.dart';
import 'package:shavishank/specialaccess/orderdelivery.dart';

//change quantities of products, pricing, delete, add. //hand over deliveries to delivery boy         //shavishank main
//get delivery goals,    scan qr                                //deliveryboy


class SpecialAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor:  Color.fromARGB(255,78,100,123),
        title: Text("Special Access" ,style: TextStyle(
            color: Colors.white
        ),),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),

          children: [
            SACards(title: "Inspect items", subinfo: "Update product details", pushwidget: InspectItem(),),
            SACards(title: "Orders & Delivery", subinfo: "Assign orders to a delivery boy", pushwidget: OrderAndDelivery()),
            SACards(title: "My Delivery", subinfo: "Deliveries assigned to me", pushwidget: MyDelivery(admin: true,),)
          ],
        ),
      ),
    );
  }
}




class SACards extends StatelessWidget {
  String title;
  String subinfo;
  Widget pushwidget;
  SACards({this.title , this.subinfo , this.pushwidget});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: FlatButton(
          height: double.infinity,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => pushwidget));
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title , style: TextStyle(
                  fontSize: 20
                ),),
                SizedBox(height: 20,),
                Text(subinfo , style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

