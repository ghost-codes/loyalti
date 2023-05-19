import 'package:flutter/material.dart';
import 'package:loyalty/utils/text.dart';

class PrimaryButtonWidget extends StatefulWidget {
  PrimaryButtonWidget({
    Key? key,
    required this.title,
    this.onPressed,
    this.isEnabled = true,
    this.width,
    this.leading,
    this.trailing,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  bool isEnabled;
  final double? width;
  final Widget? leading;
  final Widget? trailing;

  @override
  _PrimaryButtonWidgetState createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 36,
      width: widget.width,
      child: TextButton(
        onPressed: widget.isEnabled ? widget.onPressed : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              widget.isEnabled ? theme.primaryColor : const Color(0xff848484)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Row(
          children: [
            widget.leading ?? const SizedBox.shrink(),
            LoyaltiText.sectionTitle("Checkout", color: Colors.white),
            widget.trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
