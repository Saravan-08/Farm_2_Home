import 'package:flutter/material.dart';
import 'package:farm2home_mobile/src/ui/splash/splash_screen.dart';
import 'package:farm2home_mobile/src/ui/auth/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String productDetails = '/product-details';
  // ... add other routes here

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        // Replace with actual home screen widget
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Home Screen'))));
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Not Found'))));
    }
  }
}
