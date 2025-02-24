import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/components/custom_Product.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

import '../../components/custom_back_app_bar.dart';

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
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return CustomAllProductItem(
              productId: product.id,
              type: product.type,
              productModel: product,
              mainImage: product.mainImage,
              title: product.title,
              price: product.price,
            );
          },
        ),
      ),
    );
  }
}
