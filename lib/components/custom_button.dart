import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 24.0,
        ),
      ),
      child: Text(
        textButton,
        style: AppTextStyles.getSubtitleSize().copyWith(color: backgroundColor),
      ),
    );
  }
}
