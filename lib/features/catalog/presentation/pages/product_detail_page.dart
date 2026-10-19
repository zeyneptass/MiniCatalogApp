import 'package:flutter/material.dart';
import 'package:mini_catalog_app/features/catalog/domain/entities/product.dart';

import '../widgets/product_detail_content_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isAddedToCart = false;

  void _toggleCartState() {
    setState(() {
      _isAddedToCart = !_isAddedToCart;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isAddedToCart
              ? '${widget.product.title} sepete eklendi!'
              : '${widget.product.title} sepetten çıkarıldı.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ProductDetailContentWidget(
        product: widget.product,
        isAddedToCart: _isAddedToCart,
        onCartToggle: _toggleCartState,
      ),
    );
  }
}
