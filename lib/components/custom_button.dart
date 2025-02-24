import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onTapAction;

  const CustomButton({
    super.key,
    required this.textButton,
    required this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22.0),
        width: double.infinity,
        height: 64.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: btnBackgroundGradient,
        ),
        child: Text(
          textAlign: TextAlign.center,
          textButton,
          style: AppTextStyles.getSubtitleSize().copyWith(
            color: backgroundColor,
            fontSize: 18,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
