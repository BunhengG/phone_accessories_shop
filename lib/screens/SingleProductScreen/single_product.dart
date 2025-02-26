import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/core/config/AppStrings.dart';

import '../../components/custom_back_app_bar.dart';
import '../../components/custom_button.dart';
import '../../data/models/cart_item_database.dart';
import '../../data/models/product_model.dart';
import '../../logic/helper/colors_option.dart';
import '../../logic/singleproductBloc/bloc/singleproduct_bloc.dart';
import '../../logic/singleproductBloc/bloc/singleproduct_event.dart';
import '../../logic/singleproductBloc/bloc/singleproduct_state.dart';
import '../../theme/colors_theme.dart';
import '../../theme/text_theme.dart';

class SingleProduct extends StatelessWidget {
  final String productId;
  final String productType;

  const SingleProduct({
    super.key,
    required this.productId,
    required this.productType,
  });

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch the product data when the widget is first built
    context.read<SingleProductBloc>().add(FetchProduct(productType, productId));

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomBackAppBar(title: ''),
      ),
      body: BlocBuilder<SingleProductBloc, SingleProductState>(
        builder: (context, state) {
          if (state is SingleProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SingleProductLoaded) {
            final product = state.product;
            final availableColors = state.availableColors;
            final selectedColor = state.selectedColor;
            final quantity = state.quantity;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageGallery(product),
                const SizedBox(height: 16),
                _buildProductDetails(
                  product,
                  context,
                  availableColors,
                  selectedColor,
                  quantity,
                ),
              ],
            );
          }

          if (state is SingleProductError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("Error loading product"));
        },
      ),
    );
  }

  Widget _buildProductDetails(
    ProductModel product,
    BuildContext context,
    List<String> availableColors,
    String? selectedColor,
    int quantity,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: AppTextStyles.getSubtitleSize(),
          ),
          const SizedBox(height: 16),
          Text(
            "\$${product.price}",
            style: AppTextStyles.getTitleSize().copyWith(color: primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            product.shortDescription,
            style: AppTextStyles.getSIMISubtitleSize(),
          ),
          const SizedBox(height: 16),

          // Color Selection
          _buildColorSelector(product, context),

          const SizedBox(height: 8),

          // Quantity Selection
          _buildQuantitySelector(context),

          const SizedBox(height: 25),
          CustomButton(
            textButton: 'Add To Cart',
            onTapAction: () async {
              await CartItemDatabase().addItem(
                product.galleryImages.first,
                product.title,
                product.price,
                selectedColor ?? "Default",
                quantity,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item added to cart!")),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildImageGallery(ProductModel product) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: product.galleryImages.map((imageUrl) {
          return Container(
            margin: const EdgeInsets.only(left: 16.0),
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: compBackgroundGradientOption,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 200,
              height: 280,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Image.asset(
                  'assets/img/pd_placeholder.png',
                  width: 200,
                  height: 280,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/img/error.png',
                width: 200,
                height: 280,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildColorSelector(ProductModel product, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              backgroundColor: backgroundColor,
              useSafeArea: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      SizedBox(
                        height: 50.0,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    AppStrings.singleProduct.color,
                                    style: AppTextStyles.getTitleSize(),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 5,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Content
                      Column(
                        children: product.colors.map(
                          (color) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<SingleProductBloc>()
                                    .add(SelectColor(color));
                                // Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                margin: const EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                  gradient: context.select(
                                              (SingleProductBloc bloc) =>
                                                  bloc.selectedColor) ==
                                          color
                                      ? btnBackgroundGradient
                                      : compBackgroundGradientOption,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      color,
                                      style: context.select(
                                                (SingleProductBloc bloc) =>
                                                    bloc.selectedColor,
                                              ) ==
                                              color
                                          ? AppTextStyles.getSubtitleSize()
                                              .copyWith(color: backgroundColor)
                                          : AppTextStyles.getSubtitleSize(),
                                    ),
                                    const SizedBox(width: 8),
                                    Row(
                                      children: [
                                        Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: context.select(
                                                      (SingleProductBloc
                                                              bloc) =>
                                                          bloc.selectedColor,
                                                    ) ==
                                                    color
                                                ? getColorFromString(color)
                                                : thirdColor,
                                            shape: BoxShape.circle,
                                            border: context.select(
                                                      (SingleProductBloc
                                                              bloc) =>
                                                          bloc.selectedColor,
                                                    ) ==
                                                    color
                                                ? Border.all(
                                                    color: backgroundColor,
                                                    width: 3,
                                                    strokeAlign: BorderSide
                                                        .strokeAlignOutside,
                                                  )
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(width: 25),
                                        if (context.select(
                                              (SingleProductBloc bloc) =>
                                                  bloc.selectedColor,
                                            ) ==
                                            color)
                                          const Icon(
                                            Icons.check,
                                            color: backgroundColor,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: compBackgroundGradient,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Color',
                  style: AppTextStyles.getTitleSize().copyWith(fontSize: 20.0),
                ),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: context.select((SingleProductBloc bloc) =>
                            getColorFromString(
                                bloc.selectedColor ?? product.colors.first)),
                      ),
                    ),
                    const SizedBox(width: 25.0),
                    Image.asset(
                      'assets/icon/arrow_drop_down.png',
                      width: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            gradient: compBackgroundGradient,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quantity",
                style: AppTextStyles.getTitleSize().copyWith(fontSize: 20.0),
              ),
              Row(
                children: [
                  _buildActionQty(
                    'assets/icon/add_icon.png',
                    () {
                      final currentQuantity =
                          context.read<SingleProductBloc>().quantity;
                      context.read<SingleProductBloc>().add(
                            ChangeQuantity(currentQuantity + 1),
                          );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "${context.read<SingleProductBloc>().quantity}",
                      style: AppTextStyles.getSubtitleSize(),
                    ),
                  ),
                  _buildActionQty(
                    'assets/icon/remove_icon.png',
                    () {
                      final currentQuantity =
                          context.read<SingleProductBloc>().quantity;
                      if (currentQuantity > 1) {
                        context.read<SingleProductBloc>().add(
                              ChangeQuantity(currentQuantity - 1),
                            );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionQty(String imagePath, VoidCallback onAction) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onAction,
        icon: Image.asset(
          imagePath,
          width: 16,
        ),
      ),
    );
  }
}
