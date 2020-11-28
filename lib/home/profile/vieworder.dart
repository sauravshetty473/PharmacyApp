import 'package:flutter/material.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';
import 'package:shavishank/shared/orders.dart';


class ViewOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrderData(context),
      

      builder: (BuildContext context ,snapshot){
        if(snapshot.data==null){
          return Loading();
        }

        List active = snapshot.data[0];
        List passive = snapshot.data[1];


        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
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
                    child: snapshot.data[0].length!=0?Column(
                        children: active.map((e) => OrderTable(alternative: e)).toList()
                    ):Center(child: Text("No active orders"),),
                  )
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                    child: snapshot.data[1].length!=0?Column(
                        children: passive.map((e) => OrderTable(alternative: e)).toList()
                    ):Center(child: Text("No completed orders"),),
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




