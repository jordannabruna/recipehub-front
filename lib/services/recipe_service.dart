import 'package:dio/dio.dart';
import '../core/api_client.dart';
import '../models/recipe_model.dart';

class RecipeService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Recipe>> getRecipes() async {
    try {
      final response = await _apiClient.client.get('/recipes/');
      return (response.data as List)
          .map((e) => Recipe.fromJson(e))
          .toList();
    } catch (e) {
      print('Erro ao buscar receitas: $e');
      return [];
    }
  }

  Future<bool> createRecipe(Recipe recipe) async {
    try {
      await _apiClient.client.post('/recipes/', data: recipe.toJson());
      return true;
    } catch (e) {
      print('Erro ao criar receita: $e');
      return false;
    }
  }

  Future<bool> updateRecipe(int id, Recipe recipe) async {
    try {
      await _apiClient.client.put('/recipes/$id', data: recipe.toJson());
      return true;
    } catch (e) {
      print('Erro ao atualizar: $e');
      return false;
    }
  }

  Future<bool> deleteRecipe(int id) async {
    try {
      await _apiClient.client.delete('/recipes/$id');
      return true;
    } catch (e) {
      print('Erro ao deletar: $e');
      return false;
    }
  }
}