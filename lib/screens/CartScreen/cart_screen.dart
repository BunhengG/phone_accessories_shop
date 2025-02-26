import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phone_accessories_shop/components/custom_button.dart';
import 'package:phone_accessories_shop/core/config/AppStrings.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';
import '../../components/custom_back_app_bar.dart';
import '../../data/models/cart_item_database.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartItemDatabase cartDB = CartItemDatabase();

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    await cartDB.fetchCartItems();
    setState(() {});
  }

  Future<void> deleteItem(int id) async {
    await cartDB.deleteItem(id);
    loadCartItems();
  }

  Future<void> deleteAllItems() async {
    await cartDB.deleteAllItems();
    loadCartItems();
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in cartDB.currentCartItem) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = calculateTotalPrice();
    double shippingCost = 2.50;
    double tax = 0.07;
    double total = subtotal + shippingCost + tax;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomBackAppBar(title: 'Cart'),
      ),
      body: cartDB.currentCartItem.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: AppTextStyles.getSubtitleSize(),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildRemoveAll(),
                _buildItemList(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 25.0,
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow("Subtotal", subtotal),
                      _buildSummaryRow("Shipping Cost", shippingCost),
                      _buildSummaryRow("Tax", tax),
                      _buildSummaryRow("Total", total),
                      const SizedBox(height: 20),

                      // Checkout Button
                      CustomButton(textButton: 'Checkout', onTapAction: () {}),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildRemoveAll() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        child: Text(
          'Remove All',
          style: AppTextStyles.getSubtitleSize(),
        ),
        onPressed: () async {
          await deleteAllItems();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "All items removed from cart!",
                style: TextStyle(color: backgroundColor),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemList() {
    return Expanded(
      child: ListView.builder(
        itemCount: cartDB.currentCartItem.length,
        itemBuilder: (context, index) {
          final item = cartDB.currentCartItem[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.red,
              child: const Icon(Icons.delete, color: backgroundColor),
            ),
            onDismissed: (direction) async {
              await deleteItem(item.id);
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
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: Image.asset(
                'assets/img/pd_placeholder.png',
                width: 45,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/error.png',
              width: 45,
            ),
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 12.0),
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
                            style: AppTextStyles.getSubtitleSize()
                                .copyWith(fontSize: 14),
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
            style: AppTextStyles.getSIMISubtitleSize().copyWith(fontSize: 16),
          ),
          Text("\$${amount.toStringAsFixed(2)}",
              style: AppTextStyles.getSubtitleSize()
                  .copyWith(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
