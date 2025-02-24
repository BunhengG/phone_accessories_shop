abstract class SingleProductEvent {}

class FetchProduct extends SingleProductEvent {
  final String type;
  final String id;
  FetchProduct(this.type, this.id);
}

// Event to change the color
class SelectColor extends SingleProductEvent {
  final String color;
  SelectColor(this.color);
}

// Event to change the quantity
class ChangeQuantity extends SingleProductEvent {
  final int quantity;
  ChangeQuantity(this.quantity);
}
