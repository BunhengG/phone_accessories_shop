import '../../core/api/api_service.dart';
import '../../core/network/api_constants.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  // Fetch top selling products
  Future<List<ProductModel>> fetchTopSellingProducts() async {
    try {
      final response = await apiService.get(ApiConstants.topSellingEndpoint);

      final data =
          response is Map<String, dynamic> ? response['data'] : response;

      if (data is List) {
        return data
            .map(
              (json) => ProductModel.fromJson(json),
            )
            .toList();
      } else {
        throw Exception("Unexpected response format: $data");
      }
    } catch (e) {
      throw Exception("Failed to fetch top-selling products: $e");
    }
  }

  // Fetch new products
  Future<List<ProductModel>> fetchNewInProducts() async {
    try {
      final response = await apiService.get(ApiConstants.newInEndpoint);

      final data =
          response is Map<String, dynamic> ? response['data'] : response;

      if (data is List) {
        return data
            .map(
              (json) => ProductModel.fromJson(json),
            )
            .toList();
      } else {
        throw Exception("Unexpected response format: $data");
      }
    } catch (e) {
      throw Exception("Failed to fetch top-selling products: $e");
    }
  }

  // Fetch products by category
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      final String url = "${ApiConstants.productByCategoryEndpoint}$category";
      final response = await apiService.get(url);

      final data =
          response is Map<String, dynamic> ? response['data'] : response;

      if (data is List) {
        return data
            .map(
              (json) => ProductModel.fromJson(json),
            )
            .toList();
      } else {
        throw Exception("Unexpected response format: $data");
      }
    } catch (e) {
      throw Exception("Failed to fetch products for category $category: $e");
    }
  }

  // Fetch product by Id (Single Product)
  Future<ProductModel> fetchProduct(String type, String id) async {
    try {
      final String url = "${ApiConstants.productByIdEndpoint}$type/$id";
      final response = await apiService.get(url);

      if (response is Map<String, dynamic>) {
        final data = response['data'] ?? response;
        if (data != null) {
          return ProductModel.fromJson(data);
        } else {
          throw Exception("No data found in response");
        }
      } else {
        throw Exception("Invalid response format: ${response.runtimeType}");
      }
    } catch (e) {
      throw Exception("Failed to fetch product with type $type and ID $id: $e");
    }
  }
}
