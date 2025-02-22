import 'package:phone_accessories_shop/data/models/product_model.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductModel> topSellingProducts;
  final List<ProductModel> newInProducts;
  HomeLoaded({
    required this.topSellingProducts,
    required this.newInProducts,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
