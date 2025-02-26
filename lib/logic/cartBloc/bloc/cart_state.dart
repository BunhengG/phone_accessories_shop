import '../../../data/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  CartLoaded(this.cartItems);
}

class CartEmpty extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
