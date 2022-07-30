import 'package:flutter/material.dart';

const Color lightBlue = Color.fromRGBO(220, 238, 255, 1);
const Color darkBlue = Color.fromRGBO(139, 199, 255, 1);
const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);
const Color blackShadow = Color.fromRGBO(0, 0, 0, 0.1);
const Color appBlack = Color.fromRGBO(85, 85, 85, 1);
const Color borderBlack = Color.fromRGBO(85, 85, 85, 0.1);
const Color dangerRed = Color.fromRGBO(255, 0, 0, 1);
const Color facebookBlue = Color(0xff1878F2);

const LinearGradient blueGradient =
    LinearGradient(colors: [lightBlue, darkBlue], begin: Alignment.topCenter, end: Alignment.bottomCenter);

const TextStyle errorStyle = TextStyle(color: dangerRed);

ThemeData darkTheme = ThemeData(
    backgroundColor: white,
    disabledColor: appBlack,
    errorColor: dangerRed,
    fontFamily: 'Poppins',
    primaryColor: lightBlue,
    secondaryHeaderColor: darkBlue,
    canvasColor: borderBlack,
    shadowColor: blackShadow,
    textTheme: TextTheme(
        headline1: TextStyle(color: appBlack, fontWeight: FontWeight.w700, fontSize: 36, fontFamily: 'Poppins'),
        headline2: TextStyle(color: appBlack, fontWeight: FontWeight.w600, fontSize: 32, fontFamily: 'Poppins'),
        headline3: TextStyle(color: appBlack, fontWeight: FontWeight.w600, fontSize: 28, fontFamily: 'Poppins'),
        headline4: TextStyle(color: appBlack, fontWeight: FontWeight.w600, fontSize: 24, fontFamily: 'Poppins'),
        headline5: TextStyle(color: appBlack, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'Poppins'),
        headline6: TextStyle(color: appBlack, fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Poppins'),
        bodyText1: TextStyle(color: appBlack, fontSize: 20, fontFamily: 'Poppins'),
        bodyText2: TextStyle(color: appBlack, fontSize: 14, fontFamily: 'Poppins'),
        button: TextStyle(color: facebookBlue, fontSize: 14, fontFamily: 'Poppins'),
        subtitle1: TextStyle(color: darkBlue, fontSize: 16, fontFamily: 'Poppins'),
        subtitle2: TextStyle(color: darkBlue, fontSize: 8, fontFamily: 'Poppins')));
