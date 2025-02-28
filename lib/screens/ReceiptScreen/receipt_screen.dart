import 'package:flutter/material.dart';

import '../../components/custom_back_app_bar.dart';
import '../../components/custom_button.dart';
import '../../theme/colors_theme.dart';
import '../../theme/config/AppStrings.dart';
import '../../theme/text_theme.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: AppStrings.ordersPage.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/empty_order.png',
              width: 120,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.notificationPage.emptyMessage,
              style: AppTextStyles.getSubtitleSize(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: CustomButton(
                textButton: 'Explore',
                onTapAction: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
