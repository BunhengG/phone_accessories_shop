import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import '../../../theme/config/Category.dart';
import '../../../theme/text_theme.dart';
import '../ProductByCategoriesScreen/product_by_categories_name.dart';

Widget buildCategoriesSection({
  required BuildContext context,
  TextStyle? textStyle,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 14.0),
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
        margin: const EdgeInsets.only(right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: thirdColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _image,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 60,
              child: Center(
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.getSIMISubtitleSize(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
