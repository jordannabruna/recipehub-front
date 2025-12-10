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
      backgroundColor: const Color(0xFFF9FAFB), // Fundo claro
      appBar: AppBar(
        title: Text(
          "Detalhes da Receita", 
          style: GoogleFonts.inter(
            color: Colors.black87, 
            fontWeight: FontWeight.w700, 
            fontSize: 16
          )
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        leading: const BackButton(color: Colors.black87),
        actions: [
          // Botão Editar
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black54),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeFormScreen(recipe: recipe))),
          ),
          // Botão Excluir
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Imagem (Placeholder ou URL)
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://source.unsplash.com/800x400/?food,meal'),
                  fit: BoxFit.cover,
                ),
                color: Colors.grey, // Cor de fundo caso a imagem falhe
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da Receita
                  Text(
                    recipe.title, 
                    style: GoogleFonts.inter(
                      fontSize: 28, 
                      fontWeight: FontWeight.w800, 
                      color: const Color(0xFF111827)
                    )
                  ),
                  const SizedBox(height: 12),
                  
                  // Tags (Categoria e Tempo)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50, 
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child: Text(
                          recipe.category, 
                          style: TextStyle(
                            color: Colors.deepOrange.shade700, 
                            fontSize: 12, 
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        "${recipe.timeMinutes} minutos", 
                        style: GoogleFonts.inter(
                          color: Colors.grey[600], 
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Seção: Ingredientes
                  _sectionHeader("Ingredientes"),
                  _contentCard(
                    // Lógica simples para formatar texto em lista com bullets se houver quebras de linha
                    (recipe.description ?? '').isEmpty
                    ? "Sem ingredientes." 
                    : (recipe.description ?? '').split('\n').map((e) => "• $e").join('\n')
                  ),

                  const SizedBox(height: 24),

                  // Seção: Modo de Preparo
                  _sectionHeader("Modo de Preparo"),
                  _contentCard(recipe.instructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title, 
        style: GoogleFonts.inter(
          fontSize: 16, 
          fontWeight: FontWeight.bold, 
          color: const Color(0xFF1F2937)
        )
      ),
    );
  }

  Widget _contentCard(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        content, 
        style: GoogleFonts.inter(
          fontSize: 15, 
          height: 1.8, 
          color: Colors.grey[800]
        )
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Excluir Receita", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Tem certeza que deseja excluir '${recipe.title}'? Esta ação não pode ser desfeita."),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actionsPadding: const EdgeInsets.all(20),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300), 
              foregroundColor: Colors.black87
            ),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, 
              elevation: 0
            ),
            onPressed: () async {
              // Chama o serviço para deletar
              await RecipeService().deleteRecipe(recipe.id!);
              if (context.mounted) {
                Navigator.pop(ctx); // Fecha o diálogo
                Navigator.pop(context); // Volta para a tela anterior (Home)
              }
            },
            child: const Text("Excluir", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}