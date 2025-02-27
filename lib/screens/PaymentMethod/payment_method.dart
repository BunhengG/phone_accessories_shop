import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

import '../../components/custom_back_app_bar.dart';
import '../../theme/colors_theme.dart';
import '../../theme/config/AppStrings.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedPayment = 'Cash On Delivery';

  final List<String> _paymentMethods = [
    'Cash On Delivery',
    'Credit/Debit Card',
    'PayPal',
    'KHQR',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: AppStrings.paymentPage.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: _paymentMethods.map((method) {
                bool isSelected = method == _selectedPayment;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPayment = method;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : thirdColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // if KHQR, else text
                          method == 'KHQR'
                              ? Image.asset(
                                  'assets/icon/khqr.png',
                                  width: 76,
                                  fit: BoxFit.cover,
                                )
                              : Text(
                                  method,
                                  style:
                                      AppTextStyles.getSubtitleSize().copyWith(
                                    color: isSelected
                                        ? backgroundColor
                                        : secondaryColor,
                                  ),
                                ),
                          _buildCustomRadio(isSelected),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            CustomButton(
              textButton: 'Confirm Method',
              onTapAction: () {
                Navigator.pop(context, _selectedPayment);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomRadio(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? primaryColor : placeholderColor,
      ),
      width: 28,
      height: 28,
      child: isSelected
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 4,
                    color: backgroundColor,
                  ),
                ),
                child: const Icon(
                  Icons.circle,
                  size: 20,
                  color: Color(0xFF00FF9C),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
