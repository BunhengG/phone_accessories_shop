import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';
import '../../components/custom_back_app_bar.dart';
import '../../theme/colors_theme.dart';
import '../../theme/config/AppStrings.dart';

import 'PaymentMethodCubit.dart';
import 'Widgets/buildCustomRadio.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key});

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
        child: BlocBuilder<PaymentMethodCubit, String>(
          builder: (context, selectedPayment) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: _paymentMethods.map((method) {
                    bool isSelected = method == selectedPayment;
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<PaymentMethodCubit>()
                            .selectPaymentMethod(method);
                        Navigator.pop(context, method);
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
                              // If KHQR, show the image; otherwise, show text
                              method == 'KHQR'
                                  ? Image.asset(
                                      'assets/icon/khqr.png',
                                      width: 76,
                                      fit: BoxFit.cover,
                                    )
                                  : Text(
                                      method,
                                      style: AppTextStyles.getSubtitleSize()
                                          .copyWith(
                                        color: isSelected
                                            ? backgroundColor
                                            : secondaryColor,
                                      ),
                                    ),
                              buildCustomRadio(isSelected),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
