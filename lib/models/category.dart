class Category {
  Category({
    required this.name,
    required this.description,
    required this.colors,
    required this.userId,
    this.id,
  });

  String? id;
  final String name;
  final String description;
  final List<int> colors;
  final String userId;
}
