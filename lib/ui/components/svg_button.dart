import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgButton extends StatelessWidget {
  const SvgButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.width,
  });

  final String icon;
  final double? width;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: width ?? 30,
          color: color,
        ),
      ),
    );
  }
}
