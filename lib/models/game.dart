class Game {
  final String? id;
  final String name;
  String? description;
  final int? releasedate;
  String type;
  String? image;
  String company;
  bool favorite;

  Game({
    this.id,
    required this.name,
    this.description,
    this.releasedate,
    required this.type,
    this.image,
    required this.company,
    this.favorite = false,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      releasedate: json['releasedate'] is int
          ? json['releasedate']
          : int.tryParse(json['releasedate']?.toString() ?? ''),
      type: json['type'] ?? '',
      image: json['image'] ?? '',
      company: json['company'] ?? '',
      favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'releasedate': releasedate,
      'type': type,
      'image': image,
      'company': company,
      'favorite' : favorite,
    };
  }

  Game copyWith({
    String? id,
    String? name,
    String? description,
    int? releasedate,
    String? type,
    String? image,
    String? company,
    bool? favorite,
  }) {
    return Game(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      releasedate: releasedate ?? this.releasedate,
      type: type ?? this.type,
      image: image ?? this.image,
      company: company ?? this.company,
      favorite: favorite ?? this.favorite,
    );
  }
}
