import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:8000'; 

  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    contentType: Headers.jsonContentType,
  ));
  
  final _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print("Erro na API: ${e.response?.statusCode} - ${e.message}");
        return handler.next(e);
      },
    ));
  }

  Dio get client => _dio;
}