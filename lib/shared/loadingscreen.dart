import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shavishank/home/productrelated/productcards.dart';


//a bit to be changed

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      child: Center(
        child: SpinKitRing(
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}


class ProductLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Colors.white,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),

        children: List.filled(20,  MainProductLoading()),
      ),
    );
  }
}
