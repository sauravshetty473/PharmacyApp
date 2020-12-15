import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/appdrawer.dart';
import 'package:shavishank/home/productrelated/cart.dart';
import 'package:shavishank/home/productrelated/cartshell.dart';
import 'package:shavishank/home/productrelated/productpage.dart';
import 'package:shavishank/home/search/searchcards.dart';
import 'package:shavishank/home/search/searchmedmain.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/auth.dart';
import 'package:shavishank/services/scanQR.dart';
import 'package:shavishank/shared/csoon.dart';
import 'package:shavishank/shared/getdata.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _insidepageController = PageController(initialPage: 0);
  int _insidecurrentpage=0;
  Timer timer ;


  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer timer) {                       //using periodic function of Timer class
      _insidecurrentpage=_insidecurrentpage!=1?1:0;     //after every 10 seconds change CurrentPage
      _insidepageController.animateToPage(_insidecurrentpage, duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);         //using PageController animate to the current page
    });
  }

  

  _onPageChanged(int index){
    _insidecurrentpage = index;
  }

  @override
  Widget build(BuildContext context) {



    final AuthService _auth = AuthService();

    return Scaffold(
            drawer: AppDrawer(),
            backgroundColor: Color.fromARGB(255, 21, 35, 55),
            appBar: AppBar(centerTitle: true ,title: Text("Shavishank"), elevation: 0.0, backgroundColor: Color.fromARGB(255, 21, 35, 55),

              actions:<Widget> [
                IconButton(
                  iconSize: 25,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.notifications),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => true?ComingSoon("Notifications"):ScanPage()));

                  },
                ),
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
            ),





          body: SingleChildScrollView(                      //so that scrolling is possible
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/15,
                  color: Color.fromARGB(255, 21, 35, 55),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5,5,5,5),
                    child: FlatButton.icon(
                      color: Colors.white,
                      icon: Icon(Icons.search,
                        color: Colors.grey,
                      ),
                      label: Text("Search for pharmacy products and more",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SearchMed(),
                        ));
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: 5,
                ),




                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0,10,0,10),

                          height: MediaQuery.of(context).size.height/4,
                          child: PageView(
                            onPageChanged: _onPageChanged,
                            controller: _insidepageController,
                            children: [
                              Image(image: AssetImage("assets/images/thumb1.png"),),
                              Image(image: AssetImage("assets/images/homedel.png"),),
                            ],
                          ),
                        ),



                        SearchPacks(title : "Popular products"),
                        SearchPacks(title : "Top Selling products"),
                        SearchPacks(title : "Seasonal products"),
                        SearchPacks(title : "Today's hot deal"),
                      ],

                    ),
                  ),
                )
              ],
            ),
          ),
          );
  }
}

