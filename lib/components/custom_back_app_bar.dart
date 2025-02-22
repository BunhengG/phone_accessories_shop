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
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: thirdColor,
              radius: 24,
              child: Image.asset(
                'assets/icon/arrowleft.png',
                scale: 2,
              ),
            ),
          ),
        ),
        title: Text(title, style: AppTextStyles.getSubtitleSize()),
      ),
    );
  }
}
