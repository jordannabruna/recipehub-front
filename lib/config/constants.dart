/// Configurações e constantes da aplicação
class AppConstants {
  // URL Base da API
  static const String apiBaseUrl = 'https://recipehub-back.onrender.com';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Endpoints de Autenticação
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/users';
  static const String logoutEndpoint = '/logout';

  // Endpoints de Receitas
  static const String recipesEndpoint = '/recipes';

  // Chaves de Storage
  static const String tokenKey = 'access_token';
  static const String userKey = 'user_data';
}
