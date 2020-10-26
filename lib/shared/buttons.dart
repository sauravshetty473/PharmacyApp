import 'package:flutter/material.dart';

class AppDrawerFlatButton extends StatelessWidget {
  final Widget pushwidget;
  final String name;
  final BuildContext context;
  AppDrawerFlatButton({this.pushwidget,this.name,this.context});


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Text(name),
      onPressed: (){
        if(this.context!=null)
          Navigator.pop(this.context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => pushwidget,
          ));
      },
    );
  }
}


