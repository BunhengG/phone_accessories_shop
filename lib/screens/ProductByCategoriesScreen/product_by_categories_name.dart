import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

class ProductByCategoriesName extends StatelessWidget {
  final String categoryName;

  const ProductByCategoriesName({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Products'),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Text(
          'Category: $categoryName',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
