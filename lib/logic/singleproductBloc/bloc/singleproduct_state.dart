import '../../../data/models/product_model.dart';

abstract class SingleProductState {}

class SingleProductInitial extends SingleProductState {}

class SingleProductLoading extends SingleProductState {}

class SingleProductLoaded extends SingleProductState {
  final ProductModel product;
  final List<String> availableColors; // List of available colors
  final String? selectedColor; // Currently selected color
  final int quantity; // Quantity

  SingleProductLoaded({
    required this.product,
    required this.availableColors,
    required this.selectedColor,
    required this.quantity,
  });
}

class SingleProductError extends SingleProductState {
  final String message;
  SingleProductError(this.message);
}

class SingleProductColorUpdated extends SingleProductState {
  final String? color;
  SingleProductColorUpdated(this.color);
}

class SingleProductQuantityUpdated extends SingleProductState {
  final int quantity;
  SingleProductQuantityUpdated(this.quantity);
}
