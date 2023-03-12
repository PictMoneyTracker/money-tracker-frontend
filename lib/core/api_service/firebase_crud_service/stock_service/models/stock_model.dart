// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StockModel {
  final String id;
  final String name;
  final String symbol;
  // add more fields
  StockModel({
    required this.id,
    required this.name,
    required this.symbol,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'] as String,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StockModel copyWith({
    String? id,
    String? name,
    String? symbol,
  }) {
    return StockModel(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
    );
  }

  @override
  String toString() => 'StockModel(id: $id, name: $name, symbol: $symbol)';

  @override
  bool operator ==(covariant StockModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.symbol == symbol;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ symbol.hashCode;
}
