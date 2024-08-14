class Post {
  final int id;
  final String name;
  final String type;
  final String description;

  Post({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
    );
  }
}
