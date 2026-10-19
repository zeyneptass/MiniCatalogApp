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

factory Product.fromJson(Map<String, dynamic> json) {
    // DummyJSON uyumlu görsel yakalama (thumbnail veya images listesinden ilk eleman)
    String imgUrl = '';
    if (json['thumbnail'] != null) {
      imgUrl = json['thumbnail'];
    } else if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      imgUrl = json['images'][0];
    } else {
      imgUrl = json['imageUrl'] ?? '';
    }

    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: imgUrl,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}