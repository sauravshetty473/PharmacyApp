import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';

import 'cartshell.dart';


class ProductPage extends StatefulWidget {
  Product product;
  String id;
  ProductPage({this.product,this.id});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity=1;










  @override
  Widget build(BuildContext context) {
    return widget.id==null?Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            iconSize: 25,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CartShell()));
            },
          )
        ],
        backgroundColor:Color.fromARGB(255, 21, 35, 55),
        elevation: 0,


      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              Card(//product briefs
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/2,
                        child: Image(
                          image: NetworkImage(widget.product.imageUrl),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.name,
                            style: TextStyle(
                              fontSize: 20
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(widget.product.subinfo),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    Text(true?"In Stock":"Out of Stock",
                                      style: TextStyle(
                                        color: true?Colors.green:Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if(quantity!=1){
                                              setState(() {
                                                quantity--;
                                              });
                                            }
                                          },
                                          child: new Container(
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(color: Colors.black),

                                            ),
                                            child: new Text("-", style: new TextStyle(color: Colors.black, fontSize: 40.0)),
                                          ),//............
                                        ),

                                        SizedBox(width: 10,),

                                        Center(child: Text(quantity.toString())),

                                        SizedBox(width: 10,),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                          child: new Container(
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(color: Colors.black),

                                            ),
                                            child: new Text("+", style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                                          ),//............
                                        ),

                                      ],


                                    )
                                  ],
                                ),




                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(widget.product.myprice.toString(),
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),

                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        Text((((widget.product.price - widget.product.myprice)*100/widget.product.price)).toStringAsFixed(0)+"% off",
                                          style: TextStyle(
                                          ),
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(widget.product.price.toString(),
                                          style: TextStyle(
                                              decoration: TextDecoration.lineThrough)
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap: () async{

                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => CartShell()));
                                        await  setCartData(context,widget.product,quantity);
                                        Navigator.pop(context);


                                        Fluttertoast.showToast(msg: "Product added to cart");

                                      },
                                      child: new Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white,
                                          border: Border.all(color: Colors.black),
                                        ),
                                        child: new Text("ADD TO CART", style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                                      ),//............
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
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
                       Text(widget.product.description),
                    ],
                  ),
                ),

              )
            ],
          ),
        ),




      ),
    ):FutureBuilder(
      builder: (BuildContext context , snapshot){
        if(snapshot.data==null){
          return Loading();
        }

        return ProductPage(product : snapshot.data);
      },
      future: getProductForPage(widget.id),
    );
  }
}



Future getProductForPage(String id) async{
  Product product;
  await DatabaseService().medCollection.doc(id).get().then((value) {

    try{
      product = new Product(name: value["name"] , subinfo: value["subinfo"] , description: value["description"] , price: int.parse(value["price"]) , myprice: int.parse(value["myprice"]) , id: id ,  imageUrl: value["imageurl"] , quantity: int.parse(value["quantity"]));
    }catch(e){
      print(e.toString());
    }
  });
  return product;
}