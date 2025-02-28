import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

import '../../components/custom_Product.dart';
import '../../components/custom_back_app_bar.dart';
import '../../data/models/product_model.dart';
import '../../logic/productByCategoryBloc/bloc/product_by_category_bloc.dart';
import '../../logic/productByCategoryBloc/bloc/product_by_category_event.dart';
import '../../logic/productByCategoryBloc/bloc/product_by_category_state.dart';

class ProductByCategory extends StatelessWidget {
  final String categoryName;

  const ProductByCategory({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CustomBackAppBar(title: ''),
      ),
      body: BlocProvider(
        create: (context) =>
            ProductByCategoryBloc(RepositoryProvider.of(context))
              ..add(
                FetchProductsByCategory(
                  categoryName.toLowerCase().replaceAll(' ', '_'),
                ),
              ),
        child: BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
          builder: (context, state) {
            if (state is ProductByCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductByCategoryLoaded) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(
                    'No products found for "$categoryName"',
                    style: AppTextStyles.getSubtitleSize()
                        .copyWith(color: Colors.red),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final ProductModel product = state.products[index];

                  return Stack(
                    children: [
                      CustomProductItem(
                        productId: product.id,
                        type: product.type,
                        product: product.title,
                        mainImage: product.mainImage,
                        title: product.title,
                        price: product.price,
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icon/icon_heart.png',
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (state is ProductByCategoryError) {
              return Center(
                child: Text(
                  state.error,
                  style: AppTextStyles.getSubtitleSize()
                      .copyWith(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
