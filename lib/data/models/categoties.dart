class CategoryModel {
  final List<String> categories;
  final String description;
  final String status;

  CategoryModel({
    required this.categories,
    required this.description,
    required this.status,
  });

  // Factory constructor to parse JSON response
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categories: List<String>.from(json['categories']),
      description: json['description'],
      status: json['status'],
    );
  }
}
