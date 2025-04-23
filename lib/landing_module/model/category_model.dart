class CategoryModel {
  final String id;
  final String name;
  final String iconUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      iconUrl: json['iconUrl'],
    );
  }
}
