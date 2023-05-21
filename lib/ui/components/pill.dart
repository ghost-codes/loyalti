import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.builder,
    required this.isActive,
    required this.onTap,
  });

  final Widget Function(Color color, Color? bgColor) builder;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.green : Colors.grey.shade500;
    final bgColor = isActive ? Colors.green : null;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor?.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        child: builder(color, bgColor),
      ),
    );
  }
}
