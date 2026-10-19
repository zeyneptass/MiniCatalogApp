import 'package:flutter/material.dart';
import 'package:mini_catalog_app/features/catalog/data/repositories_impl/product_repository_impl.dart';
import 'package:mini_catalog_app/features/catalog/domain/entities/product.dart';
import 'package:mini_catalog_app/features/catalog/domain/use_cases/get_products_usecase.dart';
import 'package:mini_catalog_app/features/catalog/presentation/pages/cart_page.dart';
import 'package:mini_catalog_app/features/catalog/presentation/widgets/product_grid_widget.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late final GetProductsUseCase _getProductsUseCase;
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final repository = ProductRepositoryImpl();
    _getProductsUseCase = GetProductsUseCase(repository);
    _loadProducts();

    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _getProductsUseCase();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.title.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Catalog'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    // Örnek olarak ilk birkaç ürünü sepette göstermek veya boş liste [] geçmek için:
                    cartItems: _allProducts.take(3).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama Çubuğu Alanı
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Ürün ara...',
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Banner Görseli (Arama Çubuğunun Altı)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                color:
                    Colors.grey[100], // Boş kalan kenarlar için arka plan rengi
                width: double.infinity,
                height: 140,
                child: Image.asset(
                  'assets/banner.png',
                  fit: BoxFit.contain, // Görseli kırpmadan tam oturtur
                ),
              ),
            ),
          ),

          // İçerik Alanı
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      'Bir hata oluştu:\n$_errorMessage',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : _filteredProducts.isEmpty
                ? const Center(
                    child: Text('Aradığınız kriterlere uygun ürün bulunamadı.'),
                  )
                : ProductGridWidget(products: _filteredProducts),
          ),
        ],
      ),
    );
  }
}
