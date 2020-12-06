import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/productcards.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/loadingscreen.dart';




class SeeAll extends StatelessWidget {
  String title;
  var streamvalue;
  SeeAll(this.title){
    switch(title){
      case "Popular products":
        streamvalue = DatabaseService().medCollection.snapshots();
        break;
      case "Top Selling products":
        streamvalue = DatabaseService().topSelling.snapshots();
        break;
      case "Seasonal products":
        streamvalue = DatabaseService().seasonal.snapshots();
        break;
      case "Today's hot deal":
        streamvalue = DatabaseService().todaysHot.snapshots();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamvalue,
      builder: (context, snapshot) {
        if(snapshot.data==null){
          return Loading();
        }
        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("EXPLORE",
                          style: TextStyle(fontSize: 12),),
                        SizedBox(height: 10,),
                        Text(title,
                          style: TextStyle(fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      children: snapshot.data.docs.getRange(0, snapshot.data.docs.length>100?100:snapshot.data.docs.length).map((e) => MainProductCard(Product(e: e))).toList()
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
