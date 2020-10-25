import 'package:flutter/material.dart';
import 'package:shavishank/services/auth.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(initialPage: 0);




  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(centerTitle: true ,title: Text("Shavishank"), elevation: 0.0, backgroundColor: Colors.pinkAccent,
            actions:<Widget> [
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                },
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.search),
                onPressed: (){
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
