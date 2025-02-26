import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/theme/config/AppStrings.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

import '../screens/CartScreen/cart_screen.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: 80,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor,
                width: 4.0,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 28,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: 'https://avatar.iran.liara.run/public/30',
                  width: 48,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Image.asset(
                      'assets/img/pd_placeholder.png',
                      width: 150,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/img/error.png',
                    width: 150,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppStrings.homePage.helloUser} Bunheng!',
                  style: AppTextStyles.getTitleSize()
                      .copyWith(color: primaryColor),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${AppStrings.homePage.currentAddress} SiemReap >',
                  style: AppTextStyles.getSIMISubtitleSize(),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: btnBackgroundGradient,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: const CartIcon(iconPath: 'assets/icon/icon_cart.png'),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class CartIcon extends StatefulWidget {
  final String iconPath;

  const CartIcon({
    super.key,
    required this.iconPath,
  });

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.iconPath,
      width: 24,
      height: 24,
    );
  }
}
