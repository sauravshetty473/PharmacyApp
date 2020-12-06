import 'package:flutter/material.dart';



class ComingSoon extends StatelessWidget {
  String text;
  ComingSoon(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,78,100,123),
        elevation: 0,
        title: Text(text),
      ),

      body: Center(
        child: Text("Coming soon!!!"),
      ),
    );
  }
}
