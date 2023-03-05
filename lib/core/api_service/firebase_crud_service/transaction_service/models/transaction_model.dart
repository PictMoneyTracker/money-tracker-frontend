// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  final String id;
  final String title;
  final String? description;
  final int amount;
  final String category;
  final String spendFrom;
  final DateTime? createdAt;
  TransactionModel({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.category,
    required this.spendFrom,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'category': category,
      'spendFrom': spendFrom,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      amount: map['amount'] as int,
      category: map['category'] as String,
      spendFrom: map['spendFrom'] as String,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TransactionModel copyWith({
    String? id,
    String? title,
    String? description,
    int? amount,
    String? category,
    String? spendFrom,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      spendFrom: spendFrom ?? this.spendFrom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, title: $title, description: $description, amount: $amount, category: $category, spendFrom: $spendFrom, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.amount == amount &&
      other.category == category &&
      other.spendFrom == spendFrom &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      amount.hashCode ^
      category.hashCode ^
      spendFrom.hashCode ^
      createdAt.hashCode;
  }
}
