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
  // Dados do autor
  final String? ownerName;
  final String? ownerProfileImage;

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
    this.ownerName,
    this.ownerProfileImage,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Extrair dados do owner (retornado pelo backend)
    final owner = json["owner"] as Map<String, dynamic>?;
    final ownerName = owner?["name"] ?? 
                      owner?["full_name"] ?? 
                      json["owner_name"] ?? 
                      json["user"]?["full_name"];
    final ownerProfileImage = owner?["profile_image_url"] ?? 
                              json["owner_profile_image"] ?? 
                              json["user"]?["profile_image_url"];
    
    return Recipe(
      id: json["id"],
      title: json["title"] ?? "",
      description: json["description"],
      instructions: json["instructions"],
      ownerId: owner?["id"] ?? json["owner_id"],
      category: json["category"],
      timeMinutes: json["time_minutes"],
      imageUrl: json["image_url"],
      mealType: json["meal_type"] ?? "lunch",
      ownerName: ownerName,
      ownerProfileImage: ownerProfileImage,
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
