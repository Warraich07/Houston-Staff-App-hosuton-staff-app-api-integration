class UserModel {
  int id;
  String name;
  String email;
  String image;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
