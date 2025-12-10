class Recipe {
  final int? id;
  final String title;
  final String? description;
  final String instructions;
  final String mealType;
  final int? ownerId;

  Recipe({
    this.id,
    required this.title,
    this.description,
    required this.instructions,
    required this.mealType,
    this.ownerId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"],
      instructions: json["instructions"] ?? "",
      mealType: json["meal_type"] ?? "",
      ownerId: json["owner_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "instructions": instructions,
      "meal_type": mealType,
      "owner_id": ownerId,
    };
  }
}
