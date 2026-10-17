
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  // OOP Encapsulation / Business Logic
  bool get isExpensive => price > 500.0;
}
