import 'package:flutter/material.dart';
import '../farmer/farmer_dashboard.dart';
import '../consumer/consumer_dashboard.dart';
import '../delivery/delivery_dashboard.dart';
import '../admin/admin_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String _selectedModule = 'Farmer';
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text;

        print('🔐 Attempting login for: $email');
        
        // 1. Authenticate with Firebase Auth
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final userId = userCredential.user!.uid;
        print('✅ Login successful! User UID: $userId');
        
        // 2. DEBUG: List all documents in users collection
        print('🔍 Checking Firestore users collection...');
        final allUsers = await FirebaseFirestore.instance.collection('users').get();
        print('📊 Total users in Firestore: ${allUsers.docs.length}');
        
        for (final doc in allUsers.docs) {
          print('📄 Document ID: ${doc.id} | Data: ${doc.data()}');
        }

        // 3. Get specific user document
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        print('🎯 Looking for user document with ID: $userId');
        print('📄 Document exists: ${userDoc.exists}');
        
        if (userDoc.exists) {
          final userData = userDoc.data()!;
          print('✅ Found user data: $userData');
          final userRole = userData['role'] as String;
          
          // Continue with role verification...
          switch (_selectedModule) {
            case 'Farmer':
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FarmerDashboard()));
              break;
            case 'Consumer':
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConsumerDashboard()));
              break;
            case 'Delivery Partner':
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeliveryDashboard()));
              break;
            case 'Admin':
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
              break;
          }
        } else {
          print('❌ User document not found for UID: $userId');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User profile not found. Please contact support.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Login failed. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password. Please try again.';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        print('❌ General error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _testFirebaseConnection() async {
    print('🎯 TEST BUTTON CLICKED');
    
    try {
      // Test 1: Firebase Auth
      print('1. Testing Firebase Auth...');
      final auth = FirebaseAuth.instance;
      print('   ✅ Firebase Auth instance: $auth');
      
      // Test 2: Firestore
      print('2. Testing Firestore...');
      final firestore = FirebaseFirestore.instance;
      print('   ✅ Firestore instance: $firestore');
      
      // Test 3: List all users in collection
      print('3. Listing ALL users in Firestore...');
      final usersSnapshot = await firestore.collection('users').get();
      print('   📊 Total users found: ${usersSnapshot.docs.length}');
      
      if (usersSnapshot.docs.isEmpty) {
        print('   ❌ NO USERS FOUND IN FIRESTORE!');
      } else {
        for (final doc in usersSnapshot.docs) {
          print('   📄 Document ID: ${doc.id}');
          print('   📄 Data: ${doc.data()}');
          print('   ---');
        }
      }
      
      print('🎉 FIREBASE CONNECTION TEST COMPLETE');
      
    } catch (e) {
      print('❌ TEST FAILED WITH ERROR: $e');
    }
  }

  Color _getModuleColor() {
    switch (_selectedModule) {
      case 'Farmer':
        return Colors.green.shade700;
      case 'Consumer':
        return Colors.blue.shade700;
      case 'Delivery Partner':
        return Colors.orange.shade700;
      case 'Admin':
        return Colors.purple.shade700;
      default:
        return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final moduleColor = _getModuleColor();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              moduleColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo and Title
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: moduleColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: moduleColor.withOpacity(0.3), width: 2),
                          ),
                          child: Icon(
                            Icons.agriculture,
                            size: 40,
                            color: moduleColor,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        Text(
                          'Farm2Home',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: moduleColor,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          'Fresh from farm to your home',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Module Selection
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: moduleColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _buildModuleOption('Farmer', moduleColor, Icons.agriculture),
                              _buildModuleOption('Consumer', moduleColor, Icons.shopping_cart),
                              _buildModuleOption('Delivery Partner', moduleColor, Icons.delivery_dining),
                              _buildModuleOption('Admin', moduleColor, Icons.admin_panel_settings),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),

                        // TEMPORARY DEBUG BUTTON
                        ElevatedButton(
                          onPressed: _testFirebaseConnection,
                          child: Text('🔧 TEST FIREBASE CONNECTION'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        // Login Form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: Colors.grey.shade700),
                                  prefixIcon: Icon(Icons.email, color: moduleColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: moduleColor, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                                style: TextStyle(color: Colors.grey.shade900),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.grey.shade700),
                                  prefixIcon: Icon(Icons.lock, color: moduleColor),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                      color: moduleColor.withOpacity(0.6),
                                    ),
                                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: moduleColor, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                                style: TextStyle(color: Colors.grey.shade900),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: moduleColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Sign up functionality would be implemented here'),
                                backgroundColor: moduleColor,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            'Create new account',
                            style: TextStyle(
                              color: moduleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleOption(String module, Color color, IconData icon) {
    final isSelected = _selectedModule == module;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedModule = module),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : color,
              ),
              const SizedBox(height: 4),
              Text(
                module.split(' ').first,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}