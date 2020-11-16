import 'package:flutter/material.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/models/fillingclasses.dart';

class Cart extends StatefulWidget {
  NamePage namePage;
  Cart(this.namePage);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  void setpre(newpage){
    this.setState(() {
      widget.namePage = newpage;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("My Cart"),
      ),

      backgroundColor: Colors.grey[200],

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(10 , 20 ,10 , 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Deliver to ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(widget.namePage.firstname+" "+widget.namePage.lastname+" , "+widget.namePage.pincode,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ),
                                  )

                                ],
                              ),
                              SizedBox(height: 10

                                ,),

                              Container(
                                child: Text(widget.namePage.housename+" , "+widget.namePage.roadname+" , "+widget.namePage.city,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ProfilePage(newpage: widget.namePage , setpre: setpre,)));
                            },
                            child: new Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Colors.black.withAlpha(50)),
                              ),
                              child: new Text("Change", style: new TextStyle(color: Colors.blue, fontSize: 15.0 , fontWeight: FontWeight.w500)),
                            ),//............
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  ProductInCart(

                  ),

                  SizedBox(height: 20,),
                  ProductInCart(

                  ),

                  SizedBox(height: 20,),
                  ProductInCart(

                  ),

                  SizedBox(height: 20,),
                  ProductInCart(

                  ),

                ],
              ),
            ),
          ),



          Container(
            decoration: BoxDecoration(
              color: Colors.white,

              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),

            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\u20B92000"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10  ,vertical: 10),
                  child: Container(
                    decoration : BoxDecoration(
                      color: Color.fromARGB(255, 21, 35, 55),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5)
                      ),

                    ),

                    child: FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 50,vertical:0),
                      onPressed: (){
                      },

                      child: Text("Place Order",
                        style: TextStyle(
                          color: Colors.white,
                        ),



                      ),
                    ),
                  ),
                )



              ],
            ),
          )

        ],
      ),
    );
  }
}









class ProductInCart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height/3;

    return Container(
      height: height,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: height*2.2/3,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text("Cadbury Bournvita Pro Health Vitamins  (200 g)",
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("(200 g)",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,

                                ),
                              ),
                            ],
                          ),
                        ),

                        Flexible(
                          child: Image(
                            image: NetworkImage("https://rukminim1.flixcart.com/image/416/416/kdvzwcw0/milk-drink-mix/x/z/g/200-pro-health-vitamins-plastic-bottle-cadbury-bournvita-original-imafuzwyhpymmy6x.jpeg?q=70"),
                          ),
                        )

                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("\u20B91000",
                                  style: TextStyle(
                                    fontSize: 20



                                  ),
                                ),
                                SizedBox(width:10 ,),

                                Text("\u20B92000",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,



                                  ),
                                ),
                              ],

                            ),
                            SizedBox(height:10 ,),
                            Text("50% off",
                              style: TextStyle(
                                color: Colors.green



                              ),
                            ),
                          ],
                        ),

                        InkWell(
                          onTap: () {

                          },
                          child: new Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.black.withAlpha(50)),
                            ),
                            child: new Text("Change", style: new TextStyle(color: Colors.blue, fontSize: 15.0 , fontWeight: FontWeight.w500)),
                          ),//............
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 2,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text("Save for later"),
                    onPressed: (){

                    },
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                ),

                Expanded(
                  child: FlatButton(
                    child: Text("Remove item"),
                    onPressed: (){
                    },
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
