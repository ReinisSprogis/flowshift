
import 'package:flutter/foundation.dart';

import 'employee.dart';
import 'languages.dart';

@immutable
class CallLine {
  final String id;
  final String name;
  final List<Language> language;
  final List<Employee> employees;
  final DateTime startTime;
  final DateTime endTime;

  CallLine({
    required this.id,
    required this.name,
    required this.language,
    required this.employees,
    required this.startTime,
    required this.endTime,
  });

  factory CallLine.fromJson(Map<String, dynamic> json) {
    return CallLine(
      id: json['id'],
      name: json['name'],
      language: json['language'].map<Language>((e) => Language.fromJson(e)).toList(),
      employees: json['employees'].map<Employee>((e) => Employee.fromJson(e)).toList(),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'language': language.map((e) => e.toJson()).toList(),
      'employees': employees.map((e) => e.toJson()).toList(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CallLine{id: $id, name: $name, language: $language, employees: $employees, startTime: $startTime, endTime: $endTime,';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallLine &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          language == other.language &&
          employees == other.employees &&
          startTime == other.startTime &&
          endTime == other.endTime;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      language.hashCode ^
      employees.hashCode ^
      startTime.hashCode ^
      endTime.hashCode;

      //copyWith method
  CallLine copyWith({
    String? id,
    String? name,
    List<Language>? language,
    List<Employee>? employees,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return CallLine(
      id: id ?? this.id,
      name: name ?? this.name,
      language: language ?? this.language,
      employees: employees ?? this.employees,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
  
}