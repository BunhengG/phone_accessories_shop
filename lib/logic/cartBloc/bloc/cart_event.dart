abstract class CartEvent {}

class LoadCartItems extends CartEvent {}

class DeleteItem extends CartEvent {
  final int id;
  DeleteItem(this.id);
}

class DeleteAllItems extends CartEvent {}
