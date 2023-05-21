import 'package:flutter/material.dart';
import 'package:loyalty/utils/typography.dart';

class LoyaltiText {
  static Text bodyText(String text,
          {Color? color,
          TextAlign? textAlign,
          double fontSize = 15,
          FontWeight fontWeight = FontWeight.w400}) =>
      Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.bodyText(color: color, fontSize: fontSize, fontWeight: fontWeight),
      );

  static Text description(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.bodyText(color: color, fontSize: 18),
      );

  static Text sectionTitle(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.sectionTitle(color: color),
      );

  static Text title(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.title(color: color, fontSize: 24),
      );

  static Text header(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.header(color: color),
      );
}
