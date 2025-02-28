import 'package:flutter/material.dart';

import '../../components/custom_back_app_bar.dart';
import '../../theme/colors_theme.dart';
import '../../theme/config/AppStrings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: AppStrings.profilePage.title),
      ),
    );
  }
}
