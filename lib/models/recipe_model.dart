class Recipe {
  final int? id;
  final String title;
  final String? description;
  final String? instructions;
  final int? ownerId;
  final String? category;
  final int? timeMinutes;
  final String? imageUrl;
  final String? mealType;

  Recipe({
    this.id,
    required this.title,
    this.description,
    this.instructions,
    this.ownerId,
    this.category,
    this.timeMinutes,
    this.imageUrl,
    this.mealType = 'lunch',
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"],
      instructions: json["instructions"],
      ownerId: json["owner_id"],
      category: json["category"],
      timeMinutes: json["time_minutes"],
      imageUrl: json["image_url"],
      mealType: json["meal_type"] ?? "lunch",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "instructions": instructions,
      "owner_id": ownerId,
      "category": category,
      "time_minutes": timeMinutes,
      "image_url": imageUrl,
      "meal_type": mealType ?? "lunch",
    };
  }
}
