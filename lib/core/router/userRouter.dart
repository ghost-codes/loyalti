import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loyalty/ui/components/food_detail.dart';
import 'package:loyalty/ui/pages/user/home.dart';
import 'package:loyalty/ui/pages/user/login.dart';

class UserRoutes {
  static const home = "home";
  static const login = "login";
  static const foodDetails = "food_details";
}

final userRouter = GoRouter(
  debugLogDiagnostics: kDebugMode,
  observers: [RouteObserver()],
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/login",
      name: UserRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/",
      name: UserRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: "/food/:id",
      name: UserRoutes.foodDetails,
      builder: (context, state) => FoodDetailPage(
        id: state.pathParameters["id"]!,
      ),
    ),
  ],
);
