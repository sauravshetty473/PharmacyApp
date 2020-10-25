import 'package:flutter/material.dart';


class Dots extends StatelessWidget {
  final bool active;
  Dots(this.active);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: active?EdgeInsets.all(10):EdgeInsets.all(14),
      duration: Duration(milliseconds: 100),
      height: active?10:6,
      width: active?10:6,
      decoration: BoxDecoration(
        color: active?Colors.blue:Colors.grey,
        borderRadius: active?BorderRadius.all(Radius.circular(12)):BorderRadius.all(Radius.circular(8))
      ),
    );
  }
}
