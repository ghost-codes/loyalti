import 'package:flutter/material.dart';
import 'package:loyalty/utils/typography.dart';

class LoyaltiText {
  static Text bodyText(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.bodyText(color: color),
      );

  static Text sectionTitle(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.sectionTitle(color: color),
      );

  static Text header(String text, {Color? color, TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: LoyaltiTypography.header(color: color),
      );
}
