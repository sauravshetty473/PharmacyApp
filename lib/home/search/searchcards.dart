import 'package:flutter/material.dart';
import 'package:shavishank/home/productrelated/productcards.dart';




class SearchPacks extends StatelessWidget {
  final String title;
  SearchPacks({this.title});
  
  
  @override
  Widget build(BuildContext context) {
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
                    Text(title,
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
                    },
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                MainProductCard(),
                MainProductCard(),
                MainProductCard(),
                MainProductCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
