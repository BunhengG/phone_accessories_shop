import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import '../../../theme/config/AppStrings.dart';
import '../../../theme/config/Category.dart';
import '../../../theme/text_theme.dart';
import '../../CategoryScreen/category_screen.dart';
import '../../ProductByCategoriesScreen/product_by_categories_name.dart';

Widget buildCategoriesSection({
  required BuildContext context,
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
              AppStrings.homePage.categories,
              style: textStyle ?? AppTextStyles.getTitleSize(),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
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
        height: 120,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16.0),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return buildCategoryItem(
              context: context,
              title: category['title']!,
              iconPath: category['iconPath']!,
              value: category['value']!,
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
  required String value,
  required String iconPath,
}) {
  return CategoryItem(
    title: title,
    value: value,
    iconPath: iconPath,
  );
}

class CategoryItem extends StatefulWidget {
  final String title;
  final String value;
  final String iconPath;

  const CategoryItem({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
  });

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late Image _image;

  @override
  void initState() {
    super.initState();
    // Load the image once in initState
    _image = Image.asset(widget.iconPath);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductByCategory(categoryName: widget.value),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                gradient: compBackgroundGradient,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _image,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 80,
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.getSubtitleSize(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
