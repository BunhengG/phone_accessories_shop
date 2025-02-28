import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/config/AppStrings.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

Widget buildSearchField() {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: AppStrings.homePage.search,
        hintStyle: AppTextStyles.getPlaceholderSize(),
        filled: true,
        fillColor: thirdColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/icon/icon_search.png',
            width: 18,
            height: 18,
          ),
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
