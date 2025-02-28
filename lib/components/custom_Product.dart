import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/models/product_model.dart';
import 'custom_favorite_icon.dart';
import '../screens/SingleProductScreen/single_product.dart';
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
        height: 300,
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
              width: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Image.asset(
                  'assets/img/pd_placeholder.png',
                  width: 150,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/img/error.png',
                width: 150,
              ),
            ),
            Text(
              title,
              style: AppTextStyles.getSIMISubtitleSize()
                  .copyWith(color: bodyColor),
            ),
            Text(
              '\$${price.toString()}',
              style: AppTextStyles.getSubtitleSize(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAllProductItem extends StatelessWidget {
  final int productId;
  final String type;
  final ProductModel productModel;
  final String mainImage;
  final String title;
  final double price;

  const CustomAllProductItem({
    super.key,
    required this.productId,
    required this.type,
    required this.productModel,
    required this.mainImage,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 300,
          child: GestureDetector(
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
              height: 300,
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
                    placeholder: (context, url) => Center(
                      child: Image.asset(
                        'assets/img/pd_placeholder.png',
                        width: 150,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/img/error.png',
                      width: 150,
                    ),
                  ),
                  Text(
                    title,
                    style: AppTextStyles.getSubtitleSize()
                        .copyWith(color: bodyColor),
                  ),
                  Text(
                    '\$${price.toString()}',
                    style: AppTextStyles.getSubtitleSize(),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          right: 8,
          top: 8,
          child: FavoriteIcon(),
        ),
      ],
    );
  }
}
