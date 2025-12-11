import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        
        // Armazenar token no localStorage (funciona em web)
        html.window.localStorage[AppConstants.tokenKey] = token;
        
        // Armazenar dados do usuário
        html.window.localStorage[AppConstants.userKey] = jsonEncode({
          'id': data['id'],
          'email': data['email'],
          'full_name': data['full_name'],
          'profile_image_url': data['profile_image_url'],
        });
        
        print("Token e dados do usuário armazenados com sucesso");
        
        return true;
      }
      return false;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }

  Future<String?> getToken() async {
    return html.window.localStorage[AppConstants.tokenKey];
  }

  Map<String, dynamic>? getUserData() {
    final userJson = html.window.localStorage[AppConstants.userKey];
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> logout() async {
    // Limpar token e dados do usuário do localStorage
    html.window.localStorage.remove(AppConstants.tokenKey);
    html.window.localStorage.remove(AppConstants.userKey);
    print("Logout realizado - token e dados removidos");
  }
}
