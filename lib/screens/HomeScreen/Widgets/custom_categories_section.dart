import 'package:flutter/material.dart';
import '../../../core/config/AppStrings.dart';
import '../../../theme/text_theme.dart';
import '../../ProductByCategoriesScreen/product_by_categories_name.dart';

Widget buildCategoriesSection({
  required BuildContext context,
  TextStyle? textStyle,
}) {
  final List<Map<String, String>> categories = [
    {
      'title': AppStrings.categoriesPage.watch,
      'iconPath': 'assets/icon/icon_apple_watch.png'
    },
    {
      'title': AppStrings.categoriesPage.cans,
      'iconPath': 'assets/icon/icon_earphone.png'
    },
    {
      'title': AppStrings.categoriesPage.charger,
      'iconPath': 'assets/icon/icon_charger.png'
    },
    {
      'title': AppStrings.categoriesPage.phoneStands,
      'iconPath': 'assets/icon/icon_phone_stand.png'
    },
    {
      'title': AppStrings.categoriesPage.airPods,
      'iconPath': 'assets/icon/icon_airpods.png'
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.homePage.categories,
              style: textStyle ?? AppTextStyles.getTitleSize(),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.homePage.seeAll,
                style: AppTextStyles.getSubtitleSize(),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16.0),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return buildCategoryItem(
              context: context,
              title: category['title']!,
              iconPath: category['iconPath']!,
            );
          },
        ),
      ),
    ],
  );
}

Widget buildCategoryItem({
  required BuildContext context,
  required String title,
  required String iconPath,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductByCategoriesName(categoryName: title),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTextStyles.getSIMISubtitleSize(),
          ),
        ],
      ),
    ),
  );
}
