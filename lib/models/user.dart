class User {
  final String? id;
  String? name;
  String password;
  String? image;

  User({this.id, required this.name, required this.password, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'password': password,
      'image': image,
    };
  }

  User copyWith({String? id, String? name, String? password, String? image}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }
}
