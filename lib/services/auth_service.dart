import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class AuthService {
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("${AppConstants.apiBaseUrl}${AppConstants.registerEndpoint}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      print("Register Response: ${response.statusCode}");
      print("Body: ${response.body}");

      return response.statusCode == 201;
    } catch (e) {
      print("Register Error: $e");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse(
      "${AppConstants.apiBaseUrl}${AppConstants.loginEndpoint}?email=$email&password=$password",
    );

    try {
      final response = await http.post(url);

      print("Login Response: ${response.statusCode}");
      print("Body: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  Future<void> logout() async {
    // Implementar lógica de logout (limpar token, etc)
    // Por enquanto, apenas retorna
    return Future.value();
  }
}
