import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/screens/SearchScreen/search_screen.dart';
import 'package:phone_accessories_shop/theme/config/AppStrings.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

Widget buildSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(),
          ),
        );
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/icon/icon_search.png',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Text(
              AppStrings.homePage.search,
              style: AppTextStyles.getPlaceholderSize(),
            ),
          ],
        ),
      ),
    ),
  );
}
