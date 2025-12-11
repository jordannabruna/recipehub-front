import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';
import '../services/auth_service.dart';
import 'recipe_form_screen.dart';
import 'user_profile_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Recipe currentRecipe;
  late int? _currentUserId;
  bool _isOwnRecipe = false;

  @override
  void initState() {
    super.initState();
    currentRecipe = widget.recipe;
    _loadUserData();
  }

  void _loadUserData() {
    final userData = AuthService().getUserData();
    _currentUserId = userData?['id'] as int?;
    _isOwnRecipe = _currentUserId == currentRecipe.ownerId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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
          // Botão Editar (apenas se for a receita do usuário)
          if (_isOwnRecipe)
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.black54),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RecipeFormScreen(recipe: currentRecipe)),
                );
                if (result == true) {
                  setState(() {
                    // Força rebuild com dados atualizados
                  });
                }
              },
            ),
          // Botão Excluir (apenas se for a receita do usuário)
          if (_isOwnRecipe)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Imagem
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Image.network(
                currentRecipe.imageUrl ?? 'https://source.unsplash.com/800x400/?food,meal',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => 
                    const Icon(Icons.restaurant, color: Colors.orange, size: 80),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info do Autor
                  if (!_isOwnRecipe && currentRecipe.ownerId != null)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UserProfileScreen(userId: currentRecipe.ownerId!),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade100),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.orange.shade400,
                                    Colors.green.shade400,
                                  ],
                                ),
                              ),
                              child: ClipOval(
                                child: currentRecipe.ownerProfileImage != null
                                    ? Image.network(
                                        currentRecipe.ownerProfileImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.person,
                                                color: Colors.white, size: 20),
                                      )
                                    : const Icon(Icons.person,
                                        color: Colors.white, size: 20),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentRecipe.ownerName ?? "Usuário",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  Text(
                                    'Ver perfil',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: const Color(0xFFFF6600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right,
                                color: Colors.orange.shade400, size: 20),
                          ],
                        ),
                      ),
                    ),

                  // Título da Receita
                  Text(
                    currentRecipe.title, 
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
                      if (currentRecipe.category != null &&
                          currentRecipe.category!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            currentRecipe.category!, 
                            style: TextStyle(
                              color: Colors.deepOrange.shade700, 
                              fontSize: 12, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      if (currentRecipe.category != null &&
                          currentRecipe.timeMinutes != null)
                        const SizedBox(width: 16),
                      if (currentRecipe.timeMinutes != null) ...[
                        const Icon(Icons.access_time,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          "${currentRecipe.timeMinutes} minutos", 
                          style: GoogleFonts.inter(
                            color: Colors.grey[600], 
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Seção: Ingredientes
                  _sectionHeader("Ingredientes"),
                  _buildIngredientsList(
                      currentRecipe.description ?? ""),

                  const SizedBox(height: 24),

                  // Seção: Modo de Preparo
                  _sectionHeader("Modo de Preparo"),
                  _contentCard(currentRecipe.instructions ?? "Sem instruções"),
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

  Widget _buildIngredientsList(String description) {
    if (description.isEmpty) {
      return _contentCard("Sem ingredientes.");
    }

    final ingredients = description.split('\n').where((e) => e.isNotEmpty).toList();

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
        children: ingredients.map((ingredient) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.orange.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ingredient,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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
        title: Text(
          "Excluir Receita",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Tem certeza que deseja excluir '${currentRecipe.title}'? Esta ação não pode ser desfeita.",
          style: GoogleFonts.inter(color: Colors.grey[700]),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actionsPadding: const EdgeInsets.all(20),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300), 
              foregroundColor: Colors.black87,
            ),
            child: Text(
              "Cancelar",
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, 
              elevation: 0,
            ),
            onPressed: () async {
              final success = await RecipeService().deleteRecipe(currentRecipe.id!);
              if (context.mounted) {
                Navigator.pop(ctx);
                Navigator.pop(context);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Receita deletada com sucesso!',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            child: Text(
              "Excluir",
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}