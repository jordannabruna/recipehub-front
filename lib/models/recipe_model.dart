class Recipe {
  final int? id;
  final String title;
  final String? description;
  final String? instructions;
  final int? ownerId;

  Recipe({
    this.id,
    required this.title,
    this.description,
    this.instructions,
    this.ownerId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"],
      instructions: json["instructions"],
      ownerId: json["owner_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "instructions": instructions,
      "owner_id": ownerId,
    };
  }
}
