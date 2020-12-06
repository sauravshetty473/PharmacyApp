import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:shavishank/home/productrelated/productcards.dart';
import 'package:shavishank/home/search/searchmedmain.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';



class InspectItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255,78,100,123),
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(child : Text("All Items")),
              Tab(child : Text("Top Selling")),
              Tab(child : Text("Seasonal")),
              Tab(child : Text("Today's Hot")),
            ],
          ),
          title: Text("Inspect items"),
        ),
        body: TabBarView(
          children: [
            InspectPages(reference: DatabaseService().medCollection , main: true,),
            InspectPages(reference: DatabaseService().topSelling),
            InspectPages(reference: DatabaseService().seasonal),
            InspectPages(reference: DatabaseService().todaysHot),
          ],
        ),
      ),
    );
  }
}




class InspectPages extends StatelessWidget {

  CollectionReference reference;
  bool main ;
  InspectPages({this.reference , this.main : false});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context , snapshot){
        if(snapshot.data==null){
          return Center(child: SpinKitRipple(
            duration: Duration(seconds: 5),
            size: 1000,
            color:  Color.fromARGB(255,78,100,123),
          ));
        }
        return Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                children: snapshot.data.docs.map<Widget>((e) {
                  return !main?FocusedMenuHolder(child: MainProductCard(Product(e: e) , special: true),
                      animateMenuItems: false,

                      menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(title: Text("Remove from this list"),
                            trailingIcon: Icon(Icons.delete_forever_outlined , color: Colors.red,),
                            onPressed: () async{
                                await (e as QueryDocumentSnapshot).reference.delete();
                            })
                      ]
                  ):



                  FocusedMenuHolder(child: MainProductCard(Product(e: e) , special: true),
                      onPressed: null,
                      animateMenuItems: false,
                      menuItems: <FocusedMenuItem>[




                        FocusedMenuItem(title: Text("Add to TopSelling"), onPressed: () async{
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>Loading(),                     //Product page difference for special access and normal search
                          ));
                          var result = await addTOList(productid: (e as QueryDocumentSnapshot).id, category: DatabaseService().topSelling);
                          Navigator.pop(context);
                          if(result){
                            Fluttertoast.showToast(msg: "product added successfully");
                          }
                          else{
                            Fluttertoast.showToast(msg: "An error occurred");
                          }
                        }),



                        FocusedMenuItem(title: Text("Add to Seasonal"), onPressed: () async{
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>Loading(),                     //Product page difference for special access and normal search
                          ));
                          var result = await addTOList(productid: (e as QueryDocumentSnapshot).id, category: DatabaseService().seasonal);
                          Navigator.pop(context);
                          if(result){
                            Fluttertoast.showToast(msg: "product added successfully");
                          }
                          else{
                            Fluttertoast.showToast(msg: "An error occurred");
                          }
                        }),



                        FocusedMenuItem(title: Text("Add to Today's Hot"), onPressed: () async{
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>Loading(),                     //Product page difference for special access and normal search
                          ));
                          var result = await addTOList(productid: (e as QueryDocumentSnapshot).id, category: DatabaseService().todaysHot);
                          Navigator.pop(context);
                          if(result){
                            Fluttertoast.showToast(msg: "product added successfully");
                          }
                          else{
                            Fluttertoast.showToast(msg: "An error occurred");
                          }
                        }),
                        FocusedMenuItem(title: Text("Permanently DELETE"),
                            trailingIcon: Icon(Icons.delete_forever_outlined , color: Colors.red,),
                            onPressed: () async{
                              await (e as QueryDocumentSnapshot).reference.delete();
                            })
                      ]);
                }).toList()
            ),
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255,78,100,123),
            child: !main?Icon(Icons.add) : Icon(Icons.search),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SearchMed(normal: false, add: !main, category: reference,)));
            },
          ),
        );
      },
      stream: reference.snapshots(),
    );
  }
}
