import 'package:flutter/material.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';
import 'package:shavishank/shared/orders.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ViewOrders extends StatefulWidget {
  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
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
                        children: active.map((e) =>ViewOrderSnippets(e)).toList()
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





class ViewOrderSnippets extends StatefulWidget {
  var e;
  ViewOrderSnippets(this.e);
  @override
  _ViewOrderSnippetsState createState() => _ViewOrderSnippetsState();
}

class _ViewOrderSnippetsState extends State<ViewOrderSnippets> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            OrderTable(alternative: widget.e),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                  decoration : BoxDecoration(
                    color: Color.fromARGB(255, 21, 35, 55),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5)
                    ),
                  ),

                  child: FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical:0),
                    onPressed: (){
                      setState(() {
                        toggle = !toggle;
                      });
                    },
                    child:  Text(toggle==false?"GENERATE QR":"CLOSE",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),

           toggle!=false? QrImage(data: widget.e[5]):SizedBox(),
          ],
        ));
  }
}


