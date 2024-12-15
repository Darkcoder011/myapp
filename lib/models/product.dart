class Product {
  final String id;
  final String name;
  final String sku;
  final String category;
  final double price;
  final int stockQuantity;
  final String imageUrl;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    required this.stockQuantity,
    required this.imageUrl,
    required this.isActive,
  });

  bool get isLowStock => stockQuantity < 10; // Adjust threshold as needed
}
