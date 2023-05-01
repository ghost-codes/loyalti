import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatefulWidget {
  PrimaryButtonWidget({Key? key, required this.title, this.onPressed, this.isEnabled = true})
      : super(key: key);
  final String title;
  final Function()? onPressed;
  bool isEnabled;

  @override
  _PrimaryButtonWidgetState createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 51,
      width: double.infinity,
      child: TextButton(
        onPressed: widget.isEnabled ? widget.onPressed : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              widget.isEnabled ? theme.primaryColor : const Color(0xff848484)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
        child: Text(
          widget.title,
          style: theme.textTheme.button!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
