import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import '../../components/custom_app_bar.dart';
import '../../core/config/AppStrings.dart';
import '../../logic/homeBloc/bloc/home_bloc.dart';
import '../../logic/homeBloc/bloc/home_state.dart';
import '../../theme/text_theme.dart';
import 'Widgets/custom_categories_section.dart';
import 'Widgets/custom_product_section.dart';
import 'Widgets/custom_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomHomeAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  // Search
                  buildSearchField(),
                  const SizedBox(height: 16.0),

                  // Category
                  buildCategoriesSection(context: context),
                  const SizedBox(height: 16.0),

                  // Top Selling
                  buildProductSection(
                    title: AppStrings.homePage.topSelling,
                    products: state.topSellingProducts,
                    context: context,
                    isTopSelling: true,
                  ),
                  const SizedBox(height: 16.0),

                  //  New In
                  buildProductSection(
                    title: AppStrings.homePage.newIn,
                    products: state.newInProducts,
                    context: context,
                    isTopSelling: false,
                    textStyle: AppTextStyles.getTitleSize()
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red)));
          }
          return Container();
        },
      ),
    );
  }
}
