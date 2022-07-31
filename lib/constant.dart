import 'package:flutter/material.dart';

const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);
const Color blackShadow = Color.fromRGBO(0, 0, 0, 0.1);
const Color appBlack = Color.fromRGBO(85, 85, 85, 1);
const Color borderBlack = Color.fromRGBO(85, 85, 85, 0.1);
const Color dangerRed = Color.fromRGBO(255, 0, 0, 1);
const Color facebookBlue = Color(0xff1878F2);
const Color backgroundBlack = Color(0xff293241);
const Color darkerBlack = Color.fromARGB(255, 20, 26, 35);
const Color pastelTeal = Color(0xff59c9a5);

const TextStyle errorStyle = TextStyle(color: dangerRed);

ThemeData darkTheme = ThemeData(
    backgroundColor: backgroundBlack,
    disabledColor: appBlack,
    errorColor: dangerRed,
    fontFamily: 'Poppins',
    canvasColor: borderBlack,
    shadowColor: blackShadow,
    primaryColor: pastelTeal,
    scaffoldBackgroundColor: darkerBlack,
    dividerColor: white,
    textTheme: TextTheme(
        headline1: TextStyle(color: white, fontWeight: FontWeight.w700, fontSize: 36, fontFamily: 'Poppins'),
        headline2: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 32, fontFamily: 'Poppins'),
        headline3: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 28, fontFamily: 'Poppins'),
        headline4: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 24, fontFamily: 'Poppins'),
        headline5: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'Poppins'),
        headline6: TextStyle(color: white, fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Poppins'),
        bodyText1: TextStyle(color: white, fontSize: 20, fontFamily: 'Poppins'),
        bodyText2: TextStyle(color: white, fontSize: 14, fontFamily: 'Poppins'),
        button: TextStyle(color: facebookBlue, fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Poppins'),
        subtitle1: TextStyle(color: white, fontSize: 16, fontFamily: 'Poppins'),
        subtitle2: TextStyle(color: white, fontSize: 8, fontFamily: 'Poppins')));
