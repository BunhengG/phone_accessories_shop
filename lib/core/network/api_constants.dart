class ApiConstants {
  static const String baseUrl = "http://192.168.1.57:3000/api";

  // Top Product
  static const String topSellingEndpoint = "$baseUrl/products/top-selling";

  // New Product In
  static const String newInEndpoint = "$baseUrl/products/last-7-days";

  // Product by Category
  static const String productByCategoryEndpoint = "$baseUrl/products/";

  // Product by Id
  static const String productByIdEndpoint = "$baseUrl/products/";
}
