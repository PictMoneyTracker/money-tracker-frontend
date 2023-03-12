import 'dart:convert';

class ModelName {
  final String id;
  // add more fields
  ModelName({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory ModelName.fromMap(Map<String, dynamic> map) {
    return ModelName(
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelName.fromJson(String source) =>
      ModelName.fromMap(json.decode(source));
}
