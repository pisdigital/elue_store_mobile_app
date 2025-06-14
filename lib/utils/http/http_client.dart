import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class THttpHelper {
  static final localStorage = GetStorage(); // Make localStorage static
  static String _baseUrl = localStorage.read('baseUrl');

  static void updateBaseUrl(String newUrl) {
    _baseUrl = newUrl;
  }

  // Helper method to make a GET request
  static Future<dynamic> get(String endpoint) async {
    print("eeeeeeeeeeee");
    print(endpoint);
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // New helper method to make a POST request with file upload
  static Future<Map<String, dynamic>> postWithFile(String endpoint,
      Map<String, String> fields, String filePath, String fileFieldName) async {
    print("FIELDS1-1-1-: ${fields.runtimeType}");
    print("FIELDS1-1-1-: ${fields['order']}");
    var request =
        http.MultipartRequest('POST', Uri.parse('$_baseUrl/$endpoint'));
    request.fields.addAll(fields);
    print("FIELDS1-1-1-: ${request.fields}");
    request.files
        .add(await http.MultipartFile.fromPath(fileFieldName, filePath));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("RESPONSE1-1-1-: ${response.statusCode}");
    print("RESPONSEBODY1-1-1-: ${response.body}");

    return _handleResponse(response);
  }

  // Handle the HTTP response
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // Check if the body is a List or a Map and return accordingly
      if (body is List) {
        return body; // Return List if the response is a List
      } else if (body is Map<String, dynamic>) {
        return body; // Return Map if the response is a Map
      } else {
        throw Exception('Unexpected response format');
      }
    } else if (response.statusCode == 201) {
      final body = json.decode(response.body);
      return body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
