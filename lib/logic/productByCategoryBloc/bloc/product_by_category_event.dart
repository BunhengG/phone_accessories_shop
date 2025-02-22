import 'package:equatable/equatable.dart';

abstract class ProductByCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductsByCategory extends ProductByCategoryEvent {
  final String categoryName;

  FetchProductsByCategory(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}
