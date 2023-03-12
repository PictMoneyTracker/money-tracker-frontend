// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  int stockTotal = 0;
  int allowanceTotal = 0;
  int stipendTotal = 0;
  // add more fields
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.stockTotal,
    required this.allowanceTotal,
    required this.stipendTotal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'stockTotal': stockTotal,
      'allowanceTotal': allowanceTotal,
      'stipendTotal': stipendTotal,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      stockTotal: map['stockTotal'] as int,
      allowanceTotal: map['allowanceTotal'] as int,
      stipendTotal: map['stipendTotal'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    int? stockTotal,
    int? allowanceTotal,
    int? stipendTotal,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      stockTotal: stockTotal ?? this.stockTotal,
      allowanceTotal: allowanceTotal ?? this.allowanceTotal,
      stipendTotal: stipendTotal ?? this.stipendTotal,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, photoUrl: $photoUrl, stockTotal: $stockTotal, allowanceTotal: $allowanceTotal, stipendTotal: $stipendTotal)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.photoUrl == photoUrl &&
        other.stockTotal == stockTotal &&
        other.allowanceTotal == allowanceTotal &&
        other.stipendTotal == stipendTotal;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photoUrl.hashCode ^
        stockTotal.hashCode ^
        allowanceTotal.hashCode ^
        stipendTotal.hashCode;
  }
}
