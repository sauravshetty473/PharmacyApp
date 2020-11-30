import 'package:flutter/material.dart';



class ComingSoon extends StatelessWidget {
  String text;
  ComingSoon(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),

      body: Center(
        child: Text("Coming soon!!!"),
      ),
    );
  }
}
