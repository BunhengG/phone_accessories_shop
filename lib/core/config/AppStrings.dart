class AppStrings {
  static const homePage = _HomePage();
  static const categoriesPage = _CategoriesPage();
  static const topSellingPage = _TopSellingPage();
  static const newInPage = _NewInPage();
  static const notificationPage = _NotificationPage();
  static const ordersPage = _OrdersPage();
  static const singleProduct = _SingleProduct();
  static const cartPage = _CartPage();
  static const checkOutPage = _CheckOutPage();
  static const paymentMethodPage = _PaymentMethodPage();
  static const donePage = _DonePage();
  static const profilePage = _ProfilePage();
  static const addressPage = _AddressPage();
  static const wishlistPage = _WishlistPage();
  static const paymentPage = _PaymentPage();
}

class _HomePage {
  const _HomePage();
  final String helloUser = "Hello,";
  final String currentAddress = "Current in";
  final String search = "Search...";
  final String categories = "Categories";
  final String topSelling = "Top Selling";
  final String newIn = "New In";
  final String seeAll = "See All";
}

class _CategoriesPage {
  const _CategoriesPage();
  final String title = "All Categories";
  final String search = "Search...";
  final String watch = "Watch";
  final String cans = "Cans";
  final String charger = "Charger";
  final String phoneStands = "Phone Stands";
  final String airPods = "AirPods";
  final String powerBank = "Power Bank";
  final String emptyMessage =
      "Sorry, we couldn’t find any matching result for your search.";
}

class _TopSellingPage {
  const _TopSellingPage();
  final String title = "Top Selling";
  final String seeAll = "See All";
}

class _NewInPage {
  const _NewInPage();
  final String title = "New In";
}

class _NotificationPage {
  const _NotificationPage();
  final String title = "Notifications";
  final String emptyMessage = "No Notification yet";
}

class _OrdersPage {
  const _OrdersPage();
  final String title = "Orders";
  final String emptyMessage = "No Orders yet";
}

class _SingleProduct {
  const _SingleProduct();
  final String title = "";
  final String color = "Color";
  final String quantity = "Quantity";
}

class _CartPage {
  const _CartPage();
  final String title = "Cart";
  final String removeAll = "Remove All";
  final String color = "Color";
  final String subtotal = "Subtotal";
  final String shippingCost = "Shipping Cost";
  final String tax = "Tax";
  final String total = "Total";
  final String couponCode = "Enter Coupon Code";
  final String emptyMessage = "Your Cart is Empty";
}

class _CheckOutPage {
  const _CheckOutPage();
  final String title = "Checkout";
  final String shipping = "Shipping Address";
  final String payment = "Payment Method";
  final String subtotal = "Subtotal";
  final String shippingCost = "Shipping Cost";
  final String tax = "Tax";
  final String total = "Total";
}

class _PaymentMethodPage {
  const _PaymentMethodPage();
  final String title = "Payment Method";
  final String method1 = "Cash On Delivery";
  final String method2 = "KHQR";
}

class _DonePage {
  const _DonePage();
  final String title = "Order Placed Successfully";
  final String subtitle = "You will receive an email confirmation";
}

class _ProfilePage {
  const _ProfilePage();
  final String title = "Profile";
  final String address = "Address";
  final String wishlist = "Wishlist";
  final String payment = "Payment";
  final String help = "Help";
  final String support = "Support";
  final String signOut = "Sign Out";
}

class _AddressPage {
  const _AddressPage();
  final String title = "Address";
  final String emptyMessage = "Set your location now.";
}

class _WishlistPage {
  const _WishlistPage();
  final String title = "Wishlist";
  final String allMyFav = "All My Favorite";
}

class _PaymentPage {
  const _PaymentPage();
  final String title = "Payment Method";
  final String card = "Card";
  final String other = "Other Method";
  final String emptyMessage = "Set your payment method now.";
}
