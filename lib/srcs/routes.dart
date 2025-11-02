import 'package:flutter/material.dart';
import 'package:farm2home_mobile/src/ui/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        // Replace with actual login screen widget
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
