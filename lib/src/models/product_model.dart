class ProductModel {
  final String productId;
  final String farmerId;
  final String name;
  final String description;
  final String category;
  final double price;
  final String unit;
  final double quantityAvailable;
  final String? imageUrl;
  final bool available;
  final DateTime createdAt;

  ProductModel({
    required this.productId,
    required this.farmerId,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.unit,
    required this.quantityAvailable,
    this.imageUrl,
    required this.available,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'farmerId': farmerId,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'unit': unit,
      'quantityAvailable': quantityAvailable,
      'imageUrl': imageUrl,
      'available': available,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      farmerId: map['farmerId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      unit: map['unit'] ?? '',
      quantityAvailable: (map['quantityAvailable'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'],
      available: map['available'] ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
}