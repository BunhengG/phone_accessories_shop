import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

import '../../components/custom_back_app_bar.dart';
import '../ProductByCategoriesScreen/product_by_categories_name.dart';
import 'Widgets/custom_search.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomBackAppBar(title: ''),
      ),
      body: Stack(
        children: [
          // NOTE: Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shop by Categories',
                        style: AppTextStyles.getTitleSize()
                            .copyWith(color: bodyColor),
                      ),
                      const SizedBox(height: 25.0),
                      buildSearchField(),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                _buildListCategory(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCategory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListCategoryItem(
            context,
            'Watch',
            'assets/icon/icon_apple_watch.png',
            const ProductByCategory(categoryName: 'watch'),
          ),
          _buildListCategoryItem(
            context,
            'Cans',
            'assets/icon/icon_earphone.png',
            const ProductByCategory(categoryName: 'earphone'),
          ),
          _buildListCategoryItem(
            context,
            'Charger',
            'assets/icon/icon_charger.png',
            const ProductByCategory(categoryName: 'charger'),
          ),
          _buildListCategoryItem(
            context,
            'Phone Stand',
            'assets/icon/icon_phone_stand.png',
            const ProductByCategory(categoryName: 'phone_stand'),
          ),
          _buildListCategoryItem(
            context,
            'AirPods',
            'assets/icon/icon_airpods.png',
            const ProductByCategory(categoryName: 'airpods'),
          ),
        ],
      ),
    );
  }

  Widget _buildListCategoryItem(
    BuildContext context,
    String title,
    String imagePath,
    Widget targetScreen,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: compBackgroundGradient,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => targetScreen,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.getSubtitleSize(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
