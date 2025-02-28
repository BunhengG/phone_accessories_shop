import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

class CustomBackAppBar extends StatelessWidget {
  final String title;
  const CustomBackAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 8.0,
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: 40,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundColor: thirdColor,
            radius: 24,
            child: Image.asset(
              'assets/icon/arrowleft.png',
              scale: 1.5,
            ),
          ),
        ),
        title: Text(title, style: AppTextStyles.getSubtitleSize()),
      ),
    );
  }
}
