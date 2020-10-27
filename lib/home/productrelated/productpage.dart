import 'package:flutter/material.dart';


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
                          image: NetworkImage("https://5.imimg.com/data5/SE/LV/MY-62472202/cadbury-bournvita-chocolate-health-drink-2c-1kg-jar-500x500.png"),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bournvita Pro Health drink chocolate",
                            style: TextStyle(
                              fontSize: 20
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("jar of 1kg powder"),
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
                                    Text("Mfg. Mondelez India Foods Ltd."),
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {

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

                                        Center(child: Text("1")),

                                        SizedBox(width: 10,),
                                        InkWell(
                                          onTap: () {

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
                                    Text("Rs 361.0",
                                      style: TextStyle(
                                        fontSize: 20



                                      ),
                                    ),

                                    SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        Text("5% OFF",
                                          style: TextStyle(


                                          ),
                                        ),

                                        SizedBox(
                                          width: 10,

                                        ),
                                        Text("Rs 380.00",
                                          style: TextStyle(
                                              decoration: TextDecoration.lineThrough)
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    InkWell(
                                      onTap: () {

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
                      Text("Cadbury is a delicious chocolate health drink which is enriched with vitamin (d, b2, b9, b12). It combines the great taste of chocolate, and goodness of essential nutrients that aid growth and development. Bournvita is a malted chocolate drink mix that can be enjoyed piping hot or deliciously cold. Try blending bournvita with milk and ice cream to make a chocolate milkshake that is delectable and nutritious.",)

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



