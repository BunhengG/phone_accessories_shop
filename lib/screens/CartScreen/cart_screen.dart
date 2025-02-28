import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/theme/config/AppStrings.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';
import '../../components/custom_back_app_bar.dart';
import '../../data/models/cart_item_model.dart';
import '../../logic/cartBloc/bloc/cart_bloc.dart';
import '../../logic/cartBloc/bloc/cart_event.dart';
import '../../logic/cartBloc/bloc/cart_state.dart';
import '../CheckoutScreen/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: CustomBackAppBar(title: AppStrings.cartPage.title),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          // Initial load
          if (state is CartInitial) {
            Future.delayed(Duration.zero, () {
              context.read<CartBloc>().add(LoadCartItems());
            });
          }

          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartEmpty) {
            return Center(
              child: Text(
                AppStrings.cartPage.emptyMessage,
                style: AppTextStyles.getSubtitleSize(),
              ),
            );
          }

          if (state is CartError) {
            return Center(
              child:
                  Text(state.message, style: AppTextStyles.getSubtitleSize()),
            );
          }

          if (state is CartLoaded) {
            double subtotal = 0.0;
            for (var item in state.cartItems) {
              subtotal += item.price * item.quantity;
            }

            double shippingCost = 2.50;
            double tax = 0.07;
            double total = subtotal + shippingCost + tax;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildRemoveAll(context),
                _buildItemList(context, state.cartItems),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 25.0,
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow(AppStrings.cartPage.subtotal, subtotal),
                      _buildSummaryRow(
                          AppStrings.cartPage.shippingCost, shippingCost),
                      _buildSummaryRow(AppStrings.cartPage.tax, tax),
                      _buildSummaryRow(AppStrings.cartPage.total, total),
                      const SizedBox(height: 20),
                      CustomButton(
                        textButton: 'Checkout',
                        onTapAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                subtotal: subtotal,
                                shippingCost: shippingCost,
                                tax: tax,
                                total: total,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildRemoveAll(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        child: Text('Remove All', style: AppTextStyles.getSubtitleSize()),
        onPressed: () => context.read<CartBloc>().add(DeleteAllItems()),
      ),
    );
  }

  Widget _buildItemList(BuildContext context, List<CartItem> items) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.red,
              child: const Icon(Icons.delete, color: backgroundColor),
            ),
            onDismissed: (direction) async {
              context.read<CartBloc>().add(DeleteItem(item.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Item removed from cart!",
                    style: TextStyle(color: backgroundColor),
                  ),
                ),
              );
            },
            child: _buildItems(
              item.mainImage,
              item.title,
              item.price.toString(),
              item.color,
              item.quantity.toString(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItems(
    String image,
    String title,
    String price,
    String color,
    String quantity,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      color: thirdColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: Image.asset(
                'assets/img/pd_placeholder.png',
                width: 40,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/error.png',
              width: 40,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.getSubtitleSize()
                          .copyWith(color: bodyColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("\$$price", style: AppTextStyles.getSubtitleSize()),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.getSIMISubtitleSize()
                            .copyWith(color: bodyColor),
                        children: [
                          TextSpan(text: '${AppStrings.cartPage.color}: '),
                          TextSpan(
                            text: color,
                            style: AppTextStyles.getSIMISubtitleSize()
                                .copyWith(color: secondaryColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'x${quantity.toString()}',
                      style: AppTextStyles.getSIMISubtitleSize()
                          .copyWith(color: primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          Text("\$${amount.toStringAsFixed(2)}",
              style: AppTextStyles.getSubtitleSize()),
        ],
      ),
    );
  }
}
