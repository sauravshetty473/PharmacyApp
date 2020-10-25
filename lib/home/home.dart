import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shavishank/home/appdrawer.dart';
import 'package:shavishank/home/search/searchcards.dart';
import 'package:shavishank/home/search/searchmedmain.dart';
import 'package:shavishank/services/auth.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _pageController = PageController(initialPage: 0);
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


  _goback(){
    _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(


            drawer: AppDrawer(),

            backgroundColor: Colors.grey[200],
            appBar: AppBar(centerTitle: true ,title: Text("Shavishank"), elevation: 0.0, backgroundColor: Colors.pinkAccent,

              actions:<Widget> [
                IconButton(
                  iconSize: 25,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.notifications),
                  onPressed: (){

                  },
                ),
                IconButton(
                  iconSize: 25,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){
                    setState(() {
                      _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
                    });
                  },
                )
              ],
            ),

          body: SingleChildScrollView(                      //so that scrolling is possible
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
                      Image(image: AssetImage("assets/images/thumb1.png"),),

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
          ),
        SearchMed(_goback),
      ],
    );
  }
}

