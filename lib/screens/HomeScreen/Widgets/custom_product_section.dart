import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

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
            return Stack(children: [
              SizedBox(
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
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
                        // Image.network(
                        //   product.mainImage,
                        //   width: 180,
                        //   fit: BoxFit.cover,
                        // ),

                        CachedNetworkImage(
                          imageUrl: product.mainImage,
                          width: 180,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                            color: primaryColor,
                          )),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),

                        Text(
                          product.title,
                          style: AppTextStyles.getSubtitleSize()
                              .copyWith(color: bodyColor),
                        ),
                        Text(
                          product.price.toString(),
                          style: AppTextStyles.getSubtitleSize().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/icon/icon_heart.png', width: 20),
                ),
              ),
            ]);
          },
        ),
      ),
    ],
  );
}
