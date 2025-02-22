import 'package:flutter/material.dart';

import '../../../core/config/AppStrings.dart';
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
                style: AppTextStyles.getSubtitleSize(),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length > 5 ? 5 : products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              width: 120,
              margin: const EdgeInsets.only(right: 10),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(product.title, textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
