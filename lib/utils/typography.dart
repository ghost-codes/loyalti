import 'package:flutter/material.dart';

class LoyaltiTypography {
  static headerStyle() => const TextStyle(
        fontFamily: "Satoshi",
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  static TextStyle sectionTitle({Color? color}) => TextStyle(
        fontFamily: "Satoshi",
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color ?? Colors.black,
      );
  static TextStyle title({Color? color, double fontSize = 16, FontWeight? fontWeight}) => TextStyle(
        fontFamily: "Satoshi",
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? Colors.black,
      );
  static TextStyle header({Color? color}) => TextStyle(
        fontFamily: "Satoshi",
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color ?? Colors.black,
      );

  static bodyText({Color? color}) => TextStyle(
        fontFamily: "Satoshi",
        color: color ?? Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      );
}
