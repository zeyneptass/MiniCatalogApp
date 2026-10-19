import 'package:flutter/material.dart';
import 'package:mini_catalog_app/features/catalog/data/repositories_impl/product_repository_impl.dart';
import 'package:mini_catalog_app/features/catalog/domain/entities/product.dart';
import 'package:mini_catalog_app/features/catalog/domain/use_cases/get_products_usecase.dart';
import 'package:mini_catalog_app/features/catalog/presentation/pages/product_detail_page.dart';
import '../widgets/product_grid_widget.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late final GetProductsUseCase _getProductsUseCase;
  Future<List<Product>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    final repository = ProductRepositoryImpl();
    _getProductsUseCase = GetProductsUseCase(repository);
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productsFuture = _getProductsUseCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Catalog - Clean Arch'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Bir hata oluştu:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Hiç ürün bulunamadı.'));
          }

          final products = snapshot.data!;
          return ProductGridWidget(products: products);

          },
      ),
    );
  }
}
