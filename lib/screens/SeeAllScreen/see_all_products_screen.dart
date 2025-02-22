import 'package:flutter/material.dart';

class SeeAllProductsScreen extends StatelessWidget {
  final List<dynamic> products;
  final String title;

  const SeeAllProductsScreen({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.title),
          );
        },
      ),
    );
  }
}
