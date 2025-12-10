class Recipe {
  final int? id;
  final String title;
  final String description; // Vamos usar isso para "Categoria - Tempo" por enquanto
  final String instructions; // Modo de preparo
  final String? imageUrl;
  final int? ownerId;

  Recipe({
    this.id,
    required this.title,
    required this.description,
    required this.instructions,
    this.imageUrl,
    this.ownerId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      instructions: json['instructions'] ?? '',
      imageUrl: json['image_url'], // Se o back tiver
      ownerId: json['owner_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'instructions': instructions,
    };
  }
}