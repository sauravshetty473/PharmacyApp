import 'package:flutter/material.dart';
import 'package:shavishank/login/authenticate.dart';
import 'package:shavishank/models/loginslides.dart';
import 'dart:async';

import 'package:shavishank/shared/dotindicator.dart';



class LoginInfoSlideView extends StatefulWidget {
  @override
  _LoginInfoSlideViewState createState() => _LoginInfoSlideViewState();
}

class _LoginInfoSlideViewState extends State<LoginInfoSlideView> {
  PageController _pageController = PageController(initialPage: 0);              //private page controller to control the pages(login slides)
  int _currentpage = 0;

/*  @override
  void dispose() {                                                              //called whenever memory is freed, example when the state is not changing , dispose is called // we can use this opportunity to automate
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer timer) {                       //using periodic function of Timer class
      _currentpage=_currentpage!=LoginSlidesList.length-1?_currentpage+1:0;     //after every 10 seconds change CurrentPage
      _pageController.animateToPage(_currentpage, duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);         //using PageController animate to the current page
    });
  }
 */

  _onPageChanged(int index)                                                     //this function will be provided to PageView.builder as a PageChanged parameter
  {
    setState(() {
      _currentpage = index;                                                     //currentPage must be equal to index on pageChange //hence keeping track of pages using currentPage

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          FlatButton(
            child: _currentpage==LoginSlidesList.length-1?Text("Login / Sign Up"):Text("Skip"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>Authenticate(),
              ));
            },
          )
        ],
      ),

      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: PageView.builder(                                                //difference between normal PageView and PageView.builder(it has an item builder which accepts a function)
                scrollDirection: Axis.horizontal,
                onPageChanged: _onPageChanged,                                        //only reference is enough since its a single input function
                controller: _pageController,
                itemCount: LoginSlidesList.length,
                itemBuilder: (ctx,i)=>SlideItem(i),                                   //providing an anonymous function which takes the context ctx and int i (its building item from i=0 to length-1)
              )
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=0 ; i < LoginSlidesList.length ;i++)
                _currentpage==i?Dots(true):Dots(false)
            ],
          )
        ],

      ),
    );
  }
}

