import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:dio/dio.dart';
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
    try {
      print("Tentando fazer login com email: $email");
      print("URL: ${AppConstants.apiBaseUrl}${AppConstants.loginEndpoint}");

      final dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.apiBaseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
          validateStatus: (status) => status! < 500, // Não jogar erro para 4xx
        ),
      );

      // Backend espera email e password como query parameters
      final response = await dio.post(
        AppConstants.loginEndpoint,
        queryParameters: {
          'email': email,
          'password': password,
        },
      );

      print("Login Response: ${response.statusCode}");
      print("Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        // Backend retorna 'token', não 'access_token'
        final token = data['token'] ?? data['access_token'];
        
        if (token == null) {
          print("ERRO: Token não encontrado na resposta");
          return false;
        }
        
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
    } on DioException catch (e) {
      print("Login DioError Type: ${e.type}");
      print("Login Message: ${e.message}");
      print("Login Response Status: ${e.response?.statusCode}");
      print("Login Response Data: ${e.response?.data}");
      
      if (e.type == DioExceptionType.connectionTimeout) {
        print("ERRO: Timeout ao conectar na API");
      } else if (e.type == DioExceptionType.unknown) {
        print("ERRO: Problema de conexão de rede ou CORS");
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
