import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../screens/SingleProduct/single_product.dart';
import '../theme/colors_theme.dart';
import '../theme/text_theme.dart';

class CustomProductItem extends StatelessWidget {
  final int productId;
  final String type;
  final String product;
  final String mainImage;
  final String title;
  final double price;

  const CustomProductItem({
    super.key,
    required this.productId,
    required this.type,
    required this.product,
    required this.mainImage,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleProduct(
              productType: type,
              productId: productId.toString(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: thirdColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: mainImage,
              width: 180,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
              ),
            ),
            Text(
              title,
              style: AppTextStyles.getSubtitleSize().copyWith(color: bodyColor),
            ),
            Text(
              price.toString(),
              style: AppTextStyles.getSubtitleSize().copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
