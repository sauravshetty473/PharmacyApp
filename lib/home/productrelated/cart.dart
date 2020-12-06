import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/profile/profile.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/Payments/payment.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/getdata.dart';

class Cart extends StatefulWidget {
  NamePage namePage;
  List temp;

  Cart(this.namePage,this.temp);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List secondtemp;
  int totalprice=0;

  @override
  void initState() {
     secondtemp = widget.temp;
    super.initState();
  }

  void setpre(newpage){
      widget.namePage = newpage;
      setState(() {
      });
  }



  void setsta(String id) async{
    secondtemp =  await getCartData(id);
    setState((){
    });
  }


  @override
  Widget build(BuildContext context) {
    totalprice = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,78,100,123),
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

                 ...secondtemp.map((e) {
                   this.totalprice += int.parse((e as CartProductInfo).quantity)*int.parse((e as CartProductInfo).myprice);             //Very important casting as class
                   return ProductInCart(e,widget.namePage,this.setsta);
                 }).toList(),

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
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("\u20B9"+totalprice.toString(),style: TextStyle(fontSize: 20),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10  ,vertical: 10),
                  child: this.totalprice!=0?Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration : BoxDecoration(
                      color: Color.fromARGB(255, 21, 35, 55),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5)
                      ),

                    ),

                    child: FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 50,vertical:0),
                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Payment(name: widget.namePage.firstname + " " + widget.namePage.lastname,amount: totalprice.toString(),email: widget.namePage.emailid, CartItems: secondtemp,),
                        ));


                      },
                      child:  Text("Place Order",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ):SizedBox(height:48 ,),
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

  CartProductInfo e;
  NamePage _namePage;
  Function setsta;


  ProductInCart(this.e,this._namePage,this.setsta);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height/3;

    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
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
                                    child: Text(e.name,
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
                                  Text(e.subinfo,
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
                                image: NetworkImage(e.imageurl),
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
                                    Text("\u20B9"+e.myprice,
                                      style: TextStyle(
                                        fontSize: 20



                                      ),
                                    ),
                                    SizedBox(width:10 ,),

                                    Text("\u20B9"+e.price,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,



                                      ),
                                    ),
                                  ],

                                ),
                                SizedBox(height:10 ,),
                                Text(((double.parse(e.price)-double.parse(e.myprice))*100/double.parse(e.price)).toStringAsFixed(0)+"% off",
                                  style: TextStyle(
                                    color: Colors.green
                                  ),
                                ),

                                Row(

                                  children: [
                                    Text("quantity", style: TextStyle(color: Colors.black.withAlpha(100)),),
                                    
                                    Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(100),
                                            borderRadius: BorderRadius.all(Radius.circular(10))),

                                        child: Text(e.quantity , style: TextStyle(color: Colors.white , fontSize: 20), )),
                                  ],
                                ),
                              ],
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
                thickness: 1,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children : [
                          Text("Save for later",style: TextStyle(color: Colors.black.withAlpha(100) ,fontSize: 20),),
                          Text("coming soon",style: TextStyle(color: Colors.black.withAlpha(100))),
                        ]),
                        onPressed: (){

                        },
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                    ),

                    Expanded(
                      child: FlatButton(
                        child: Text("Remove item"),
                        onPressed: () async{
                          await DatabaseService().Userdata.doc(_namePage.id).collection("Cart").doc(e.id).delete();
                          setsta(_namePage.id);
                        },
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}
