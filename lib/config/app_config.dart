import 'dart:html' as html;

/// Classe para gerenciar configurações da aplicação
class AppConfig {
  static late final String apiBaseUrl;

  /// Inicializar configurações (deve ser chamado na main)
  static void init() {
    // Tentar obter da variável de ambiente (process.env no web)
    // Se não existir, usar valor padrão
    apiBaseUrl = _getEnvironmentVariable('API_BASE_URL') ?? 
        'https://recipehub-back.onrender.com';
    
    print('API Base URL: $apiBaseUrl');
  }

  /// Obter variável de ambiente (para Flutter Web)
  static String? _getEnvironmentVariable(String key) {
    try {
      // Para Flutter Web, as variáveis podem estar no window
      return html.window.parent?.eval('window.$key');
    } catch (e) {
      print('Erro ao obter variável de ambiente $key: $e');
      return null;
    }
  }
}
