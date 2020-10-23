//anything that is common //some text field decorations etc.

import 'package:flutter/material.dart';

InputDecoration idHintText(String hintext)
{
  return InputDecoration(hintText: hintext,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.zero),
      borderSide: BorderSide(color: Colors.white , width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.zero),
      borderSide: BorderSide(color: Colors.white , width: 2),
    ),
  );
}

const textInputDecoration =InputDecoration(                  //another way textInputDecoration.copyWith(hintText : "email"
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.zero),
    borderSide: BorderSide(color: Colors.white , width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.zero),
    borderSide: BorderSide(color: Colors.white , width: 2),
  ),
);
