import 'package:flutter/material.dart';
import 'package:loyalty/utils/colors.dart';

final theme = ThemeData(
  primaryColor: LoyaltiColor.primary,
  colorScheme: ColorScheme.fromSeed(seedColor: LoyaltiColor.primary),
  textTheme: const TextTheme().apply(fontFamily: "Satoshi"),
);
