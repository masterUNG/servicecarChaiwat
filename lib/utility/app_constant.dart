import 'package:flutter/material.dart';

class AppConstant {

  
  static Color dark = Colors.black;
  static String uidAdmin = 'vnnl1HWW1aNNH2Yg5ZUPVVtJ9X02';

  BoxDecoration bgBox() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
    );
  }

  TextStyle h1Style({Color? color, double? size, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 36,
      color: color ?? dark,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  TextStyle h2Style({Color? color, double? size, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 22,
      color: color ?? dark,
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  TextStyle h3Style({Color? color, double? size, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 14,
      color: color ?? dark,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
