import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    required double rating,
  }) : super(
         id: id,
         title: title,
         description: description,
         price: price,
         imageUrl: imageUrl,
         rating: rating,
       );

  // JSON'dan Model'e Dönüşüm (Mapping)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  // Model'den JSON'a Dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }
}
