import 'package:flutter/material.dart';
import 'ui/auth/login_page.dart';

class Farm2HomeApp extends StatelessWidget {
  const Farm2HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm2Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}