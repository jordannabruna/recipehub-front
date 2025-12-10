import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';
import 'recipe_form_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text("Detalhes da Receita"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeFormScreen(recipe: recipe)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Icon(Icons.image, size: 80, color: Colors.grey),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title, style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(label: const Text("Geral"), backgroundColor: Colors.orange.shade50, labelStyle: const TextStyle(color: Colors.orange)),
                      const SizedBox(width: 12),
                      const Icon(Icons.access_time, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text("30 minutos", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Ingredientes
                  _buildSectionCard(
                    title: "Ingredientes",
                    content: recipe.description.isEmpty ? "Sem ingredientes listados." : recipe.description,
                  ),
                  const SizedBox(height: 24),

                  // Modo de Preparo
                  _buildSectionCard(
                    title: "Modo de Preparo",
                    content: recipe.instructions,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(content, style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87)),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Excluir Receita"),
        content: Text("Tem certeza que deseja excluir '${recipe.title}'? Esta ação não pode ser desfeita."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () async {
              await RecipeService().deleteRecipe(recipe.id!);
              if (context.mounted) {
                Navigator.pop(ctx); // fecha dialog
                Navigator.pop(context); // volta pra home
              }
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }
}