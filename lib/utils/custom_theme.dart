import 'package:flutter/material.dart';

class CustomTheme{
  static const TextStyle headerlarge = TextStyle(
    color: Colors.white,
    fontFamily: 'BalsamiqSans',
    fontStyle: FontStyle.italic,
    fontSize: 50,
    fontWeight: FontWeight.w700
  );
  static const TextStyle headerMedium = TextStyle(
      color: Colors.white,
      fontFamily: 'BalsamiqSans',
      fontStyle: FontStyle.italic,
      fontSize: 35,
      fontWeight: FontWeight.w600
  );
  static const TextStyle header = TextStyle(
      color: Colors.white,
      fontFamily: 'BalsamiqSans',
      fontSize: 20,
      fontWeight: FontWeight.w500
  );
  static const TextStyle textInputDecoration = TextStyle(
    color: Colors.grey,
    fontFamily: 'Nunito',
    fontStyle: FontStyle.italic,
    fontSize: 18,
  );
  static const TextStyle kTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Nunito',
    fontSize: 16,
  );
  static const TextStyle headerBlack = TextStyle(
    color: Colors.black,
      fontFamily: 'BalsamiqSans',
      fontSize: 20,
      fontWeight: FontWeight.w800
  );
  static const TextStyle secondFont = TextStyle(
    color: Colors.black,
      fontFamily: 'BalsamiqSans',
      fontSize: 16,
      fontWeight: FontWeight.w500
  );
  static const TextStyle buttonFont =  TextStyle(
    color: Colors.white,
    fontFamily: 'Nunito',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static const Color circularColor1 =  Color(0xff6a1b9a);
  static const purpleGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff4a148c),
        Color(0xff6a1b9a),
        Color(0xffba68c8),
      ],);
  static const homeGradient = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xffd3d1ff),
        Color(0xffb39ddb),
        Color(0xffba68c8)
      ],);
  static const buttonDecoration = const BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.white70,
        offset: Offset(0,8),
        blurRadius: 10.0,
      ),
    ],
    gradient: purpleGradient,
  );
  static const List<BoxShadow>textFieldBoxShadow = [BoxShadow(
      color: Colors.deepPurpleAccent,
      offset: Offset(0, 10),
      blurRadius: 20)];
}
