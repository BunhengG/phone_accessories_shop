import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              radius: 24,
              child: Image.asset(
                'assets/icon/arrowleft.png',
                scale: 4,
              ),
            ),
          ),
        ),
        title: Text(title, style: AppTextStyles.getSubtitleSize()),
      ),
    );
  }
}
