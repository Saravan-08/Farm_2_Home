import 'package:flutter/material.dart';
import '../auth/login_page.dart'; // ADD THIS IMPORT

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login - FIXED
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Statistics Cards
            Row(
              children: [
                _buildStatCard('Farmers', '15', Colors.green, Icons.agriculture),
                SizedBox(width: 10),
                _buildStatCard('Consumers', '45', Colors.blue, Icons.shopping_cart),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard('Delivery', '8', Colors.orange, Icons.delivery_dining),
                SizedBox(width: 10),
                _buildStatCard('Orders', '23', Colors.purple, Icons.list_alt),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ActionChip(
                  label: Text('Verify Farmers'),
                  avatar: Icon(Icons.verified, size: 18),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Farmer verification panel')),
                    );
                  },
                ),
                ActionChip(
                  label: Text('View All Users'),
                  avatar: Icon(Icons.people, size: 18),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('Manage Products'),
                  avatar: Icon(Icons.inventory, size: 18),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('View Orders'),
                  avatar: Icon(Icons.receipt, size: 18),
                  onPressed: () {},
                ),
                ActionChip(
                  label: Text('Analytics'),
                  avatar: Icon(Icons.analytics, size: 18),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 30),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}