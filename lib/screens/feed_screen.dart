import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';
import '../services/auth_service.dart';
import 'recipe_detail_screen.dart';
import 'user_profile_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final RecipeService _recipeService = RecipeService();
  final AuthService _authService = AuthService();
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  String _searchQuery = '';
  late int? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadRecipes();
  }

  void _loadUserData() {
    final userData = _authService.getUserData();
    _currentUserId = userData?['id'] as int?;
  }

  Future<void> _loadRecipes() async {
    final recipes = await _recipeService.getRecipes();
    setState(() {
      _recipes = recipes;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _recipes.where((r) =>
        r.title.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'RecipeHub',
          style: GoogleFonts.inter(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        elevation: 1,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Barra de Pesquisa
            TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Buscar receitas...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFFF6600)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Lista de Receitas
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF6600),
                      ),
                    )
                  : filteredList.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: _loadRecipes,
                          color: const Color(0xFFFF6600),
                          child: ListView.separated(
                            itemCount: filteredList.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) =>
                                _buildRecipeCard(filteredList[index]),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cookie_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Nenhuma receita encontrada',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tente ajustar sua busca',
            style: GoogleFonts.inter(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailScreen(recipe: recipe),
          ),
        );
        _loadRecipes();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.orange.shade50,
                child: Image.network(
                  recipe.imageUrl ?? 'https://source.unsplash.com/400x200/?food,dish',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.restaurant, color: Colors.orange, size: 50),
                ),
              ),
            ),
            
            // Info do Autor
            InkWell(
              onTap: () {
                if (recipe.ownerId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserProfileScreen(userId: recipe.ownerId!),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Avatar do Autor
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
                        child: recipe.ownerProfileImage != null
                            ? Image.network(
                                recipe.ownerProfileImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.person, color: Colors.white, size: 20),
                              )
                            : const Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.ownerName ?? "Usuário",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          Text(
                            'Ver perfil',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFFFF6600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Título e Descrição
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (recipe.description != null && recipe.description!.isNotEmpty)
                    Text(
                      recipe.description!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

            // Tags (Categoria e Tempo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (recipe.category != null && recipe.category!.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        recipe.category!,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF6600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (recipe.timeMinutes != null) ...[
                    Icon(Icons.access_time,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      '${recipe.timeMinutes}min',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
