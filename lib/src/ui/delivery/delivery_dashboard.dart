import 'package:flutter/material.dart';

class DeliveryDashboard extends StatelessWidget {
  const DeliveryDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Dashboard'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delivery_dining, size: 80, color: Colors.orange),
            SizedBox(height: 20),
            Text(
              'Welcome Delivery Partner!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Manage your deliveries'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text('View Active Deliveries'),
            ),
          ],
        ),
      ),
    );
  }
}