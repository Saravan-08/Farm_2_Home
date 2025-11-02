import 'package:flutter/material.dart';

class ConsumerDashboard extends StatelessWidget {
  const ConsumerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumer Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Welcome Consumer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Discover fresh farm products'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text('Browse Products'),
            ),
          ],
        ),
      ),
    );
  }
}