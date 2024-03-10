import 'package:flutter/foundation.dart';

import 'employee.dart';

@immutable
class Shift {
  final String id;
  final DateTime start;
  final DateTime end;



  Shift({
    required this.id,
    required this.start,
    required this.end,

  });

factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Shift{id: $id, start: $start, end: $end';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shift &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode =>
      id.hashCode ^
      start.hashCode ^
      end.hashCode;

  //copyWith method
  Shift copyWith({
    String? id,
    DateTime? start,
    DateTime? end,
    List<Employee>? employees,
  }) {
    return Shift(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

}