import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

import '../theme/shadow_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<String> _iconPaths = [
    'assets/icon/home.png',
    'assets/icon/notification.png',
    'assets/icon/receipt.png',
    'assets/icon/profile.png',
  ];

  final List<String> _selectedIconPaths = [
    'assets/icon/homeActive.png',
    'assets/icon/notificationActive.png',
    'assets/icon/receiptActive.png',
    'assets/icon/profileActive.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: AppShadows.getMediumShadow(),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: secondaryColor,
        unselectedItemColor: placeholderColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: List.generate(
          _iconPaths.length,
          (index) => BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == index
                  ? _selectedIconPaths[index]
                  : _iconPaths[index],
              width: 28,
              height: 28,
            ),
            label: '',
          ),
        ),
      ),
    );
  }
}
