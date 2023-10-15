class ImageModel {
  final String id;
  final String imagePath;
  final String? description;
  final DateTime createdAt;

  ImageModel({
    required this.id,
    required this.imagePath,
    this.description,
    final DateTime? createdAt,
  }) : createdAt = DateTime.now();

  factory ImageModel.fromJson(Map<String, Object?> json) => ImageModel(
        id: json["id"] as String,
        imagePath: json["image_path"] as String,
        description:
            json["description"] == null ? null : json["description"] as String,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
      );

  Map<String, Object?> toJson() => {
        "id": id,
        "image_path": imagePath,
        "description": description,
        "created_at": createdAt,
      };
}
