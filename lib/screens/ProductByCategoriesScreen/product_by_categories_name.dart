import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

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
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: backgroundColor,
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final ProductModel product = state.products[index];

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(product.mainImage,
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.getSubtitleSize(),
                          ),
                        ),
                      ],
                    ),
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
