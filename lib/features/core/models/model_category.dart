class Category {
  final String id;
  final String title;
  final String img;

  Category({
    required this.id,
    required this.title,
    required this.img,
  });

  Map<String, dynamic> toJson(Category category) {
    // Category to Json
    final Map<String, dynamic> data = {};

    data["id"] = category.id;
    data["title"] = category.title;
    data["img"] = category.img;

    return data;
  }
}
