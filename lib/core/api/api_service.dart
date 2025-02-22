import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          "Failed to load data from $endpoint - Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Network error while fetching data: $e");
    }
  }
}
