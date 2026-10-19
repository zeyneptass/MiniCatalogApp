import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../widgets/empty_cart_widget.dart';
import '../widgets/cart_list_widget.dart';
import '../widgets/cart_bottom_section_widget.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.cartItems);
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _items.isEmpty
                  ? const EmptyCartWidget()
                  : CartListWidget(items: _items, onItemRemoved: _removeItem),
            ),
            CartBottomSectionWidget(
              isEmpty: _items.isEmpty,
              onCheckout: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sipariş işlemi başlatıldı!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
