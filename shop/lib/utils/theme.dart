import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  fontFamily: 'Lato',
  // fontFamily: 'Anton',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.purple,
    secondary: Colors.deepOrange,
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
    displaySmall: TextStyle(
      fontFamily: 'Lato',
      fontSize: 18,
      color: Colors.white,
    ),
  ),
);
