import 'package:flutter/material.dart';
import 'package:loyalty/utils/text.dart';

class DataError extends StatelessWidget {
  const DataError({Key? key, required this.onRetry}) : super(key: key);

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoyaltiText.header('Failed to load content'),
          TextButton(
            onPressed: onRetry,
            child: LoyaltiText.bodyText('Retry'),
          )
        ],
      ),
    );
  }
}
