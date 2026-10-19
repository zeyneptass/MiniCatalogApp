import 'package:flutter/material.dart';

class ProductActionButtonWidget extends StatelessWidget {
  final bool isAddedToCart;
  final VoidCallback onPressed;

  const ProductActionButtonWidget({
    super.key,
    required this.isAddedToCart,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(isAddedToCart ? Icons.check : Icons.shopping_cart),
        label: Text(
          isAddedToCart ? 'Sepette' : 'Sepete Ekle',
          style: const TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isAddedToCart ? Colors.green : Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
