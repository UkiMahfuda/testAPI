class Post {
  final int id;
  final String name;
  final String type;
  final String desc;

  Post(
      {required this.id,
      required this.name,
      required this.type,
      required this.desc});

  factory Post.fromJson(Map<String, dynamic> json) {
    // Cek apakah ada key 'data'
    if (json['data'] is List) {
      List<dynamic> data = json['data'];
      // Ambil data dari elemen pertama (asumsikan hanya ada satu item dalam 'data')
      Map<String, dynamic> postJson = data[0];
      return Post(
        id: postJson['id'],
        name: postJson['name'],
        type: postJson['type'],
        desc: postJson['desc'],
      );
    } else {
      // Handle kasus jika 'data' bukan list
      return Post(
        id: 0,
        name: "",
        type: "",
        desc: "",
      );
    }
  }
}
