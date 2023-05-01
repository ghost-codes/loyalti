import 'package:flutter/material.dart';
import 'package:loyalty/core/router/userRouter.dart';
import 'package:loyalty/ui/components/overlay/overlay_manager.dart';
import 'package:loyalty/utils/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const UserHost();
  }
}

class UserHost extends StatefulWidget {
  const UserHost({super.key});

  @override
  State<UserHost> createState() => _UserHostState();
}

class _UserHostState extends State<UserHost> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Achieve',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: userRouter,
      builder: (context, child) => Scaffold(
        body: OverlayManager(child: child!),
      ),
    );
  }
}
