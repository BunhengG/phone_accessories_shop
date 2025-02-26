import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart_item_database.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartItemDatabase cartDB = CartItemDatabase();

  CartBloc() : super(CartInitial()) {
    // Register event handlers for each type of event
    on<LoadCartItems>(_onLoadCartItems);
    on<DeleteItem>(_onDeleteItem);
    on<DeleteAllItems>(_onDeleteAllItems);
  }

  // Event Handler for LoadCartItems
  Future<void> _onLoadCartItems(
    LoadCartItems event, // Event type: LoadCartItems
    Emitter<CartState> emit, // Emitter to send new states
  ) async {
    emit(CartLoading());
    try {
      await cartDB.fetchCartItems(); // Fetch items from the database
      if (cartDB.currentCartItem.isEmpty) {
        emit(CartEmpty()); // Emit empty state if no items are found
      } else {
        emit(
            CartLoaded(cartDB.currentCartItem)); // Emit loaded state with items
      }
    } catch (e) {
      emit(CartError("Failed to load cart items"));
    }
  }

  // Event Handler for DeleteItem
  Future<void> _onDeleteItem(
    DeleteItem event,
    Emitter<CartState> emit,
  ) async {
    await cartDB.deleteItem(event.id);
    add(LoadCartItems()); // Re-load cart after deleting
  }

  // Event Handler for DeleteAllItems
  Future<void> _onDeleteAllItems(
      DeleteAllItems event, Emitter<CartState> emit) async {
    await cartDB.deleteAllItems();
    add(LoadCartItems()); // Re-load cart after clearing
  }
}
