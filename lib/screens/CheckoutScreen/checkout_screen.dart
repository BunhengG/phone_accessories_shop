import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

import '../../components/custom_back_app_bar.dart';
import '../../theme/config/AppStrings.dart';
import '../../theme/text_theme.dart';
import '../PaymentMethod/PaymentMethodCubit.dart';
import '../PaymentMethod/payment_method.dart';

class CheckoutScreen extends StatefulWidget {
  final double subtotal;
  final double shippingCost;
  final double tax;
  final double total;

  const CheckoutScreen({
    super.key,
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    required this.total,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = 'Cash On Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: AppStrings.checkOutPage.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 25.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                _buildOption(
                  'Shipping Address',
                  '7 Makara St, Krong Siem Reap...',
                  () {},
                ),
                const SizedBox(height: 16),
                _buildOption(
                  'Payment Method',
                  selectedPayment,
                  () async {
                    // Pass the selectedPayment as initial value
                    final paymentMethod = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<PaymentMethodCubit>(
                          create: (context) =>
                              PaymentMethodCubit(selectedPayment),
                          child: PaymentMethodScreen(),
                        ),
                      ),
                    );

                    if (paymentMethod != null) {
                      setState(() {
                        selectedPayment = paymentMethod;
                      });
                    }
                  },
                ),
              ],
            ),
            Column(
              children: [
                _buildSummaryRow(
                    AppStrings.checkOutPage.subtotal, widget.subtotal),
                _buildSummaryRow(
                    AppStrings.checkOutPage.shippingCost, widget.shippingCost),
                _buildSummaryRow(AppStrings.checkOutPage.tax, widget.tax),
                _buildSummaryRow(AppStrings.checkOutPage.total, widget.total),
                const SizedBox(height: 20),
                CustomButton(
                  textButton: 'Place Order',
                  onTapAction: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    String title,
    String subtitle,
    VoidCallback onTapAction,
  ) {
    return GestureDetector(
      onTap: onTapAction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: thirdColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.getSubtitleSize(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    subtitle,
                    style: AppTextStyles.getSIMISubtitleSize()
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icon/arrowright.png',
                  width: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.getSIMISubtitleSize().copyWith(fontSize: 16),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: AppTextStyles.getSubtitleSize()
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
