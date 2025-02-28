import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

import '../../components/custom_back_app_bar.dart';
import '../../theme/colors_theme.dart';
import '../../theme/config/AppStrings.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: AppStrings.notificationPage.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/empty_notification.png',
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
