import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2home_mobile/src/models/product.dart';
import 'package:farm2home_mobile/src/models/order.dart';
import 'package:farm2home_mobile/src/models/feedback.dart';
import 'package:farm2home_mobile/src/models/transaction.dart';
import 'package:farm2home_mobile/src/models/reward.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Product operations
  Stream<List<ProductModel>> getProducts() {
    return _db.collection('products').where('available', isEqualTo: true).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList());
  }

  Future<void> addProduct(ProductModel product) {
    return _db.collection('products').add(product.toFirestore());
  }

  Future<void> updateProduct(String productId, ProductModel product) {
    return _db.collection('products').doc(productId).update(product.toFirestore());
  }
  
  // Order operations
  Future<void> placeOrder(OrderModel order) {
    return _db.collection('orders').add(order.toFirestore());
  }

  Stream<List<OrderModel>> getOrdersForConsumer(String consumerId) {
    return _db
        .collection('orders')
        .where('consumerId', isEqualTo: consumerId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }
  
  Stream<List<OrderModel>> getOrdersForFarmer(String farmerId) {
    return _db
        .collection('orders')
        .where('farmerId', isEqualTo: farmerId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  Future<void> updateOrderStatus(String orderId, String status) {
    return _db.collection('orders').doc(orderId).update({'orderStatus': status});
  }
  
  // Feedback operations
  Future<void> addFeedback(FeedbackModel feedback) {
    return _db.collection('feedback').add(feedback.toFirestore());
  }

  // Transaction operations
  Future<void> addTransaction(TransactionModel transaction) {
    return _db.collection('transactions').add(transaction.toFirestore());
  }

  // Reward operations
  Future<void> updateUserRewards(String userId, RewardModel reward) {
    return _db.collection('rewards').doc(userId).set(reward.toFirestore(), SetOptions(merge: true));
  }
}
