import 'package:flutter/material.dart';

import '../../../components/custom_Product.dart';
import '../../../theme/config/AppStrings.dart';
import '../../../components/custom_favorite_icon.dart';
import '../../../theme/text_theme.dart';
import '../../SeeAllScreen/see_all_products_screen.dart';

Widget buildProductSection({
  required String title,
  required List<dynamic> products,
  required BuildContext context,
  required bool isTopSelling,
  TextStyle? textStyle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyle ?? AppTextStyles.getTitleSize(),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAllProductsScreen(
                      products: products,
                      title: title,
                    ),
                  ),
                );
              },
              child: Text(
                AppStrings.homePage.seeAll,
                style: AppTextStyles.getSubtitleSize().copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 250,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: products.length > 5 ? 5 : products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Stack(
              children: [
                SizedBox(
                  width: 190,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: CustomProductItem(
                      productId: product.id,
                      type: product.type,
                      product: product.title,
                      mainImage: product.mainImage,
                      title: product.title,
                      price: product.price,
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
          },
        ),
      ),
    ],
  );
}
