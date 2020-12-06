import 'package:flutter/material.dart';


class OrderAndDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255,78,100,123),
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(child : Text("Pending Orders")),
              Tab(child : Text("Completed Orders")),
              Tab(child : Text("Delivery")),
            ],
          ),
          title: Text("Customer Orders"),
        ),
        body: TabBarView(
          children: [
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

