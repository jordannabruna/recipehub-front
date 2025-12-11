import 'package:dio/dio.dart';
import 'dart:html' as html;
import '../config/constants.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      contentType: Headers.jsonContentType,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
    ),
  );

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = html.window.localStorage[AppConstants.tokenKey];

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print("Token adicionado ao header: Bearer ${token.substring(0, 20)}...");
          } else {
            print("Nenhum token encontrado no localStorage");
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          print("Erro de API: ${e.response?.statusCode} - ${e.message}");
          print("URL: ${e.requestOptions.uri}");
          print("Headers: ${e.requestOptions.headers}");
          return handler.next(e);
        },
      ),
    );
  }

  Dio get client => _dio;
}
