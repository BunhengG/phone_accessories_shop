import 'package:isar/isar.dart';

part 'cart_item_model.g.dart';

@Collection()
class CartItem {
  Id id = Isar.autoIncrement;
  late String mainImage;
  late String title;
  late double price;
  late String color;
  late int quantity;
}
