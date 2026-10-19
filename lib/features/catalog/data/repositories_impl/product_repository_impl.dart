import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/dummy_products_data.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    // Gerçek ağ isteği hissi vermek için 500ms gecikme ekliyoruz
    await Future.delayed(const Duration(milliseconds: 500));

    // dummy_products_data.dart içindeki 'products' listesini alıyoruz
    final List<dynamic> productsList = dummyJsonResponse['products'] as List;

    // Her bir JSON haritasını (Map) ProductModel'e dönüştürüp liste olarak döndürüyoruz
    return productsList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Product> getProductById(String id) async {
    final products = await getProducts();
    return products.firstWhere(
      (product) => product.id == int.parse(id),
      orElse: () => throw Exception('Ürün bulunamadı!'),
    );
  }
}
