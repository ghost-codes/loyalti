import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loyalty/utils/colors.dart';

class LoaderView extends StatefulWidget {
  final AnimationController controller;
  final String? message;

  const LoaderView({
    Key? key,
    required this.controller,
    this.message,
  }) : super(key: key);

  @override
  State<LoaderView> createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView> with SingleTickerProviderStateMixin {
  AnimationController get controller => widget.controller;

  late AnimationController _loadingAnimation;

  late Animation<double> blurValue = Tween(
    begin: 0.0,
    end: 8.0,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.decelerate,
  ));

  @override
  void initState() {
    super.initState();

    _loadingAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurValue.value,
              sigmaY: blurValue.value,
            ),
            child: child,
          );
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(34),
                constraints: const BoxConstraints(minWidth: 200),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: LoyaltiColor.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.message ?? 'Please wait ...',
                      style: themeData.textTheme.titleMedium!.copyWith(
                        color: LoyaltiColor.primary,
                        fontSize: 15,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loadingAnimation.dispose();
    super.dispose();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: LoyaltiColor.primary,
      ),
    );
  }
}
