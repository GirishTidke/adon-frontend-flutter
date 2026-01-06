// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../constants/api_constants.dart';

// class ApiClient {
//   static Future<http.Response> post(
//     String endpoint,
//     Map<String, dynamic> body,
//   ) async {
//     final url = Uri.parse(ApiConstants.baseUrl + endpoint);

//     return await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(body),
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_constants.dart';

class ApiClient {
  /// 🔑 Get auth headers automatically
  static Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// ============================
  /// POST
  /// ============================
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);

    final response = await http.post(
      url,
      headers: await _headers(),
      body: jsonEncode(body),
    );

    return response;
  }

  /// ============================
  /// GET
  /// ============================
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);

    final response = await http.get(
      url,
      headers: await _headers(),
    );

    return response;
  }

  /// ============================
  /// PUT
  /// ============================
  static Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);

    final response = await http.put(
      url,
      headers: await _headers(),
      body: jsonEncode(body),
    );

    return response;
  }

  /// ============================
  /// DELETE
  /// ============================
  static Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse(ApiConstants.baseUrl + endpoint);

    final response = await http.delete(
      url,
      headers: await _headers(),
    );

    return response;
  }
}
