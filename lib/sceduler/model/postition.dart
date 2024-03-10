import 'package:flutter/foundation.dart';

@immutable
class Position {
  final String id;
  final String description;

  Position({
    required this.id,
    required this.description,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }


  @override
  String toString() {
    return 'Position{id: $id, description: $description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description;


  @override
  int get hashCode => id.hashCode ^ description.hashCode;
  

  //copyWith method
  Position copyWith({
    String? id,
    String? description,
  }) {
    return Position(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  
}