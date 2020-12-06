import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shavishank/home/productrelated/productpage.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/constants.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';



class SpecialProductPage extends StatefulWidget {

  String id;
  SpecialProductPage({this.id});

  @override
  _SpecialProductPageState createState() => _SpecialProductPageState();
}

class _SpecialProductPageState extends State<SpecialProductPage> {
  int quantity ;
  int price;
  int myprice;

  @override
  Widget build(BuildContext context) {
    TextEditingController qtext = new TextEditingController();
    TextEditingController ptext = new TextEditingController();
    TextEditingController mptext = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 21, 35, 55),
        elevation: 0,



        actions: [
          FlatButton(
            child: Text("Save"  , style: TextStyle(color: Colors.white),),
            onPressed: () async{
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Loading()));
             var result =  await saveProductData(id: widget.id , price :ptext.text , myprice: mptext.text , quantity: qtext.text);
             Navigator.pop(context);
             if(result){
               Fluttertoast.showToast(msg: "Product saved successfully");
             }
             else{
               Fluttertoast.showToast(msg: "An error occurred");
             }

            },
          )
        ],
      ),

      body: StreamBuilder(
        builder: (context , snapshot){
          if(snapshot.data==null)
            {
              return Loading();
            }
          /*  final specificDocument = snapshot.data.documents.where((f){                    //important
            return f.documentID == widget.id;
          }).toList();
          */
          DocumentSnapshot temp = snapshot.data ;
          quantity = int.parse(temp.get("quantity"));
          price = int.parse(temp.get("price"));
          myprice = int.parse(temp.get("myprice"));


          qtext.text = quantity.toString();
          ptext.text = price.toString();
          mptext.text = myprice.toString();


          return SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Card(//product briefs
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height/2,
                            child: Image(
                              image: NetworkImage(temp.get("imageurl")),
                            ),
                          ),
                          Text(temp.get("name"),
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(temp.get("subinfo")),
                          SizedBox(height: 40,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Available quantity"  ,
                              style: TextStyle(fontSize: 20),),
                              SizedBox(width: 10,),
                              Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.height/5,
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w900
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: qtext,
                                        decoration: textInputDecoration.copyWith(),          //copy all the content in the predefined constant and add my own hintText
                                      ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("price"  ,
                                style: TextStyle(fontSize: 20),),
                              SizedBox(width: 10,),
                              Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.height/5,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w900
                                      ),
                                      keyboardType: TextInputType.number,
                                      controller: ptext,
                                      decoration: textInputDecoration.copyWith(),          //copy all the content in the predefined constant and add my own hintText
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("discounted price"  ,
                                style: TextStyle(fontSize: 20),),
                              SizedBox(width: 10,),
                              Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.height/5,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w900
                                      ),
                                      keyboardType: TextInputType.number,
                                      controller: mptext,
                                      decoration: textInputDecoration.copyWith(),          //copy all the content in the predefined constant and add my own hintText
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  Card(             //description
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(temp.get("description")),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        stream: DatabaseService().medCollection.doc(widget.id).snapshots(),
      )
    );
  }
}
