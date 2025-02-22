import 'package:equatable/equatable.dart';

import '../../../data/models/product_model.dart';

abstract class ProductByCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<ProductModel> products;

  ProductByCategoryLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductByCategoryError extends ProductByCategoryState {
  final String error;

  ProductByCategoryError(this.error);

  @override
  List<Object> get props => [error];
}
