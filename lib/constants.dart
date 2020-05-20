import 'package:flutter/material.dart';

TextStyle kNexaBoldWhite = TextStyle(
    fontFamily: 'Nexa Bold',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 20);

InputDecoration kInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black54),
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0XFFfd992a), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0XFFfd992a), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

TextStyle kCalendarDayTextStyle = TextStyle(
  fontSize: 12,
  color: Color(0XFFfd992a),
  shadows: <Shadow>[
    Shadow(
      offset: Offset(1.5, 1.5),
      blurRadius: 3.0,
      color: Colors.black26,
    ),
  ],
);
