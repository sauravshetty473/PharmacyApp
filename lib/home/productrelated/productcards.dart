import 'package:flutter/material.dart';
import 'package:shavishank/home/productrelated/productpage.dart';



class MainProductCard extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height/4.5;


    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,8),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),

          width: height*2/3,
          height: height ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Image(
                  image: NetworkImage("https://rukminim1.flixcart.com/image/416/416/kdvzwcw0/milk-drink-mix/x/z/g/200-pro-health-vitamins-plastic-bottle-cadbury-bournvita-original-imafuzwyhpymmy6x.jpeg?q=70"),
                ),
              ),

              FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProductPage(),
                  ));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  height: height/2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /*Divider(
                        thickness: 1,
                        height: 0,
                      ),*/


                      SizedBox(
                        height: 5,
                      ),


                      Container(

                          child :Text(
                            "This is a sample long text line we are using in our example.",
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            softWrap: false,
                          )),
                      SizedBox(height: 5,),

                      Row(
                        children: [
                          Text("\u20B9200",
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                          ),

                          SizedBox(
                            width: 5,
                          ),
                          Text("\u20B9300",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 3,),

                      Text("\u20B9300 off",
                        style: TextStyle(
                            color: Colors.green,
                        ),
                      ),




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


class ProductSearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
