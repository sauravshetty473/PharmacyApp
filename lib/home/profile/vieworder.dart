import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/services/scanQR.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';
import 'package:shavishank/shared/orders.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shavishank/shared/textformfield.dart';


class ViewOrders extends StatefulWidget {
  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context , listen:  false);
    return StreamBuilder(
      stream: DatabaseService().Userdata.doc(user.uid).collection("Order").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data == null) {
          return Loading();
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(

            appBar: AppBar(
              backgroundColor: Color.fromARGB(255,78,100,123),
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(child : Text("Active")),
                  Tab(child : Text("Completed")),
                ],
              ),
              title: Text("My Orders"),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),

                      child: Column(
                        children: (snapshot.data as QuerySnapshot).docs.map((e) {
                          return e.get("completed")=="true"?SizedBox():NewOrderTable(e);
                        }).toList(),
                      )
                    )
                ),
                SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                        child: Column(
                          children: (snapshot.data as QuerySnapshot).docs.map((e) {
                            return e.get("completed")=="false"?SizedBox():NewOrderTable(e);
                          }).toList(),
                        )
                    )
                ),
              ],
            ),
          ),
        );
        },
    );   
  }
  }


  
  
  class NewOrderTable extends StatefulWidget {
  String out_for_delivery;
  String genQR;
  QueryDocumentSnapshot e;
  NewOrderTable(this.e,{this.out_for_delivery,this.genQR});
    @override
    _NewOrderTableState createState() => _NewOrderTableState();
  }
  
  class _NewOrderTableState extends State<NewOrderTable> {
  


    @override
    Widget build(BuildContext context) {
      final List<OrderSnippets> items=[];
      for(int i = 0 ; i < List.from(widget.e.get("itemsid")).length ; i++){
        items.add(new OrderSnippets(name: List.from(widget.e.get("itemsname"))[i], price: List.from(widget.e.get("itemsprice"))[i], quantity: List.from(widget.e.get("itemsquantity"))[i], id: List.from(widget.e.get("itemsid"))[i]));
      }



      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));
      print(widget.e.get("orderID"));



      return Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Order ID : " + widget.e.get("orderID"), style: TextStyle(fontSize: 20),),
                ),
                Text("Date : " + widget.e.get("date")),
                Divider(height: 10, thickness: 1,),
                ...items.map((e) => Row(
                  children: [
                    Expanded(
                      flex: 5,
                        child: TextOverFlow(e.name)),
                    Expanded(child: Align(alignment:Alignment.centerRight,child: Text(e.quantity))),
                    Expanded(child: Align(alignment:Alignment.centerRight,child: Text(e.price))),
                  ],
                )).toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: TextOverFlow("Total price")),
                      Expanded(child: Text("")),
                      Expanded(child: Align(alignment:Alignment.centerRight,child: Text(widget.e.get("totalprice"), style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500),))),
                    ],
                  ),
                ),
                Divider(height: 10, thickness: 1,),
                SizedBox(height: 5,),
                widget.out_for_delivery == null? QrImage(data: widget.e.get("code")) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [Text(widget.e.get("Firstname")+ " " + widget.e.get("Lastname") , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),)],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [Text("phone : "), Text(widget.e.get("Phone")),
                            widget.e.get("AltPhone")!=""?Row(
                              children: [Text("  ( "+widget.e.get("AltPhone")  + " )")],
                            ):SizedBox(),

                          ],
                        ),

                        Divider(height: 20, thickness: 1,),
                        Text(widget.e.get("Pincode"), style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),),
                        SizedBox(height: 5,),
                        Text(widget.e.get("Housename")),
                        Text(widget.e.get("Roadname")),

                        widget.e.get("Landmark")!=""?Text(widget.e.get("Landmark")):SizedBox(),
                        SizedBox(height: 5,),
                        Text(widget.e.get("City") , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),),
                        Text(widget.e.get("State"),  style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500),),
                        SizedBox(height: 10,),

                      ],
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration : BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text(widget.e.get("prepaid")=="prepaid"?"Prepaid":"COD"),
                    ),


                    widget.genQR!=null?FlatButton(
                      minWidth: 0,
                      height: 0,
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ScanPage(code: widget.e.get("code"), orderID: widget.e.get("orderID"),)));
                      },
                      child:  Container(
                        decoration : BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("Scan QR", style: TextStyle(fontSize: 20),),
                      ),

                    ):SizedBox()
                  ],
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      );
    }
  }

  class OrderSnippets{
  String name;
  String quantity;
  String price;
  String id;
  OrderSnippets({this.name, this.quantity, this.price, this.id});
  }

