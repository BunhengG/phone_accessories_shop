import 'package:flutter/material.dart';

import '../../../theme/colors_theme.dart';

Widget buildCustomRadio(bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isSelected ? primaryColor : placeholderColor,
    ),
    width: 24,
    height: 24,
    child: isSelected
        ? Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 3,
                  color: backgroundColor,
                ),
              ),
              child: const Icon(
                Icons.circle,
                size: 16,
                color: Color(0xFF00FF9C),
              ),
            ),
          )
        : const SizedBox.shrink(),
  );
}
