import 'package:flutter/material.dart';

class FlipkartTextField extends StatefulWidget {
  final String hintext;
  final int duration;
  final double shrinkpad;
  final double expandpad;
  final double shrinksize;
  final double expandsize;
  final number;
  FlipkartTextField({this.hintext , this.duration , this.shrinkpad, this.expandpad,this.shrinksize,this.expandsize,this.number=false});

  @override
  _FlipkartTextFieldState createState() => _FlipkartTextFieldState();
}

class _FlipkartTextFieldState extends State<FlipkartTextField> {
  String input="";
  bool _tap = false;


  void _onChanged(String input)
  {
    setState(() {
      this.input = input;
      _tap=true;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          padding: _tap?EdgeInsets.fromLTRB(0,widget.shrinkpad,0,0):EdgeInsets.fromLTRB(0,widget.expandpad,0,0),
          duration: Duration(milliseconds: widget.duration!=null?widget.duration:200),
          child: AnimatedDefaultTextStyle(
              child: Text(widget.hintext),
              duration: Duration(milliseconds: 200),
              style: _tap?TextStyle(
                  color: Colors.blue,
                  fontSize: widget.shrinksize!=null?widget.shrinksize:10,
              ):
              TextStyle(
                  color: Colors.black,
                  fontSize: widget.expandsize!=null?widget.expandsize:15,
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,0),
          child: TextFormField(
            keyboardType: widget.number?TextInputType.number:TextInputType.text,
            onChanged: _onChanged,
            onTap: ()
            {
              setState(() {
                _tap = true;
              });
            },
            onEditingComplete: (){
              setState(() {
                if(input=="")
                _tap =false;
              });
            },
          ),
        ),
      ],
    );
  }
}
