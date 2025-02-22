import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/core/config/AppStrings.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

Widget buildSearchField() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: AppStrings.homePage.search,
        hintStyle: AppTextStyles.getPlaceholderSize(),
        filled: true,
        fillColor: thirdColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/icon/icon_search.png',
            width: 20,
            height: 20,
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
