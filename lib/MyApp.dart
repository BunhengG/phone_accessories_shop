import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

import 'components/custom_bottom_bar.dart';
import 'screens/HomeScreen/home_screen.dart';
import 'screens/NotificationScreen/notification_screen.dart';
import 'screens/ProfileScreen/profile_screen.dart';
import 'screens/ReceiptScreen/receipt_screen.dart';

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  final int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const ReceiptScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/notification');
        break;
      case 2:
        Navigator.pushNamed(context, '/receipt');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
