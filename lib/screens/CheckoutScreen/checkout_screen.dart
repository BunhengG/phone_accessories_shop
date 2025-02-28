import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

import '../../components/custom_back_app_bar.dart';
import '../../data/models/cart_item_database.dart';
import '../../data/models/location_model.dart';
import '../../theme/config/AppStrings.dart';
import '../../theme/text_theme.dart';
import '../ChooseLocation/location.dart';
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
  String selectedAddress = '';
  String selectedPayment = 'Cash On Delivery';

  @override
  void initState() {
    super.initState();
    _loadAddressFromDatabase();
  }

  // Method to load the address from the database
  Future<void> _loadAddressFromDatabase() async {
    List<Location> locations = await CartItemDatabase().fetchLocation();
    if (locations.isNotEmpty) {
      setState(() {
        selectedAddress = locations.last.address;
      });
    }
  }

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
                  selectedAddress.isEmpty
                      ? 'Select a location'
                      : selectedAddress,
                  () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectLocationScreen(),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        selectedAddress = result['address'];
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                _buildOption(
                  'Payment Method',
                  selectedPayment,
                  () async {
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
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: AppTextStyles.getSIMISubtitleSize(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icon/arrowright.png',
                  width: 10,
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
            style: AppTextStyles.getSIMISubtitleSize(),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: AppTextStyles.getSubtitleSize(),
          ),
        ],
      ),
    );
  }
}
