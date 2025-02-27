import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'cart_item_model.dart';

class CartItemDatabase {
  static late Isar isar;

  // initializes - database
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();

    isar = await Isar.open(
      [CartItemSchema],
      directory: dir.path,
    );
  }

  // list of cart items
  final List<CartItem> currentCartItem = [];

  // Create - a CartItem and save to db
  Future<void> addItem(
    String mainImage,
    String title,
    double price,
    String color,
    int quantity,
  ) async {
    // Create a new cart item
    final newItem = CartItem()
      ..mainImage = mainImage
      ..title = title
      ..price = price
      ..color = color
      ..quantity = quantity;

    // save to database
    await isar.writeTxn(() async {
      final id = await isar.cartItems.put(newItem);
      print('✅ Item added to database with ID: $id');
    });

    // Re-fetch items after adding
    fetchCartItems();
  }

  // READ - cartItems from db
  Future<void> fetchCartItems() async {
    List<CartItem> fetchedCartItem = await isar.cartItems.where().findAll();
    currentCartItem.clear();
    currentCartItem.addAll(fetchedCartItem);
  }

  // DELETE - a cartItem from db
  Future<void> deleteItem(int id) async {
    final oneItem = await isar.writeTxn(() => isar.cartItems.delete(id));

    await fetchCartItems();
    print('🗑️ A CartItem deleted: $oneItem');
  }

  // DELETE - all cartItems from db
  Future<void> deleteAllItems() async {
    final allItemIds = await isar.cartItems.where().idProperty().findAll();
    // Delete all items using their IDs
    await isar.writeTxn(() => isar.cartItems.deleteAll(allItemIds));

    // Re-fetch items after deletion
    await fetchCartItems();
    print('🗑️ All CartItems deleted');
  }

  Stream<int> cartItemCountStream() async* {
    final isar = Isar.getInstance();
    if (isar == null) {
      yield 0; // Emit 0 if Isar is not initialized
      return;
    }

    // Emit the initial cart item count
    yield await isar.cartItems.count();

    // Listen for changes in the cart collection
    yield* isar.cartItems.watchLazy().asyncMap((_) async {
      return await isar.cartItems.count();
    });
  }
}
