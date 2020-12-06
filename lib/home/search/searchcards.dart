import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/productcards.dart';
import 'package:shavishank/home/productrelated/seeall.dart';
import 'package:shavishank/services/database.dart';




class SearchPacks extends StatelessWidget {
  final String title;
  var streamvalue;
  SearchPacks({this.title}){
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

    final list = Provider.of<QuerySnapshot>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height/3,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8 ,8 ,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("EXPLORE",
                    style: TextStyle(fontSize: 12),),
                    SizedBox(height: 10,),
                    Text(this.title,
                    style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold


                    ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("SEE ALL",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,

                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SeeAll(this.title)));
                    },
                  ),
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: streamvalue,
            builder: (context ,snapshot){

              if(snapshot.data==null){
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [MainProductLoading(),MainProductLoading(),MainProductLoading(),MainProductLoading(),MainProductLoading()],
                  ),
                );
              }


              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: snapshot.data.docs.getRange(0, snapshot.data.docs.length>10?10:snapshot.data.docs.length).map<Widget>((e) => MainProductCard(Product(e: e))).toList()
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



