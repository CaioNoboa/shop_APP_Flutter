import 'package:flutter/material.dart';
import 'package:shop/utils/custom_route.dart';

ThemeData appTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CustomPageTransitionsBuilder(),
    },
  ),
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
