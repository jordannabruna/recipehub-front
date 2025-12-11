import 'package:dio/dio.dart';
import '../core/api_client.dart';
import '../models/recipe_model.dart';
import '../config/constants.dart';

class RecipeService {
  final ApiClient _apiClient = ApiClient();

  // GET /recipes - Buscar todas as receitas de todos os usuários
  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await _apiClient.client.get(AppConstants.recipesEndpoint);
      
      print("GetRecipes Response: ${response.statusCode}");
      print("Data: ${response.data}");
      
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Recipe.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar receitas: $e');
      return [];
    }
  }

  // GET /recipes/me/my-recipes - Buscar receitas do usuário logado
  Future<List<Recipe>> getMyRecipes() async {
    try {
      final response = await _apiClient.client.get('${AppConstants.recipesEndpoint}/me/my-recipes');
      
      print("GetMyRecipes Response: ${response.statusCode}");
      print("Data: ${response.data}");
      
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Recipe.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar minhas receitas: $e');
      return [];
    }
  }

  // GET /recipes/user/{user_id} - Buscar receitas de um usuário específico
  Future<List<Recipe>> getUserRecipes(int userId) async {
    try {
      final response = await _apiClient.client.get('${AppConstants.recipesEndpoint}/user/$userId');
      
      print("GetUserRecipes Response: ${response.statusCode}");
      print("Data: ${response.data}");
      
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Recipe.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar receitas do usuário: $e');
      return [];
    }
  }

  Future<bool> createRecipe(Recipe recipe) async {
    try {
      final response = await _apiClient.client.post(
        AppConstants.recipesEndpoint,
        data: recipe.toJson(),
      );
      
      print("CreateRecipe Response: ${response.statusCode}");
      print("Data: ${response.data}");
      
      return response.statusCode == 201;
    } catch (e) {
      print('Erro ao criar receita: $e');
      return false;
    }
  }

  Future<bool> updateRecipe(int id, Recipe recipe) async {
    try {
      final response = await _apiClient.client.put(
        '${AppConstants.recipesEndpoint}/$id',
        data: recipe.toJson(),
      );
      
      print("UpdateRecipe Response: ${response.statusCode}");
      
      return response.statusCode == 200;
    } catch (e) {
      print('Erro ao atualizar: $e');
      return false;
    }
  }

  Future<bool> deleteRecipe(int id) async {
    try {
      final response = await _apiClient.client.delete(
        '${AppConstants.recipesEndpoint}/$id',
      );
      
      print("DeleteRecipe Response: ${response.statusCode}");
      
      return response.statusCode == 204;
    } catch (e) {
      print('Erro ao deletar: $e');
      return false;
    }
  }
}
