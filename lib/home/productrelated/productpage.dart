import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/getdata.dart';


class ProductPage extends StatefulWidget {
  Product product;
  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity=1;










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                        await setCartData(context,widget.product,quantity);
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
    );
  }
}



