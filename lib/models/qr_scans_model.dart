class QrScansModel {
  int id;
  int offerId;
  String title;
  String description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  QrScansModel({
    required this.id,
    required this.offerId,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QrScansModel.fromJson(Map<String, dynamic> json) => QrScansModel(
    id: json["id"],
    offerId: json["offer_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_id": offerId,
    "title": title,
    "description": description,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
