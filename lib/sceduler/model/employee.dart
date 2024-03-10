
import 'package:flutter/foundation.dart';

import 'absence.dart';
import 'postition.dart';
import 'shift.dart';

@immutable
class Employee {
final String id;
final String name;
final String surname;
final String email;
final String phone;
final Position position;
final double monthlyWorkHours;
final List<Shift> shifts;
final Absence? absence;

Employee({
  required this.id,
  required this.name,
  required this.surname,
  required this.email,
  required this.phone,
  required this.position,
  required this.monthlyWorkHours,
  required this.shifts,
  this.absence,
});


factory Employee.fromJson(Map<String, dynamic> json) {
  return Employee(
    id: json['id'],
    name: json['name'],
    surname: json['surname'],
    email: json['email'],
    phone: json['phone'],
    position: Position.fromJson(json['position']),
    monthlyWorkHours: json['monthlyWorkHours'],
    shifts: json['shifts'].map<Shift>((e) => Shift.fromJson(e)).toList(),
    absence: json['absence'] != null ? Absence.fromJson(json['absence']) : null,
  );
}


Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'surname': surname,
    'email': email,
    'phone': phone,
    'position': position.toJson(),
    'monthlyWorkHours': monthlyWorkHours,
    'shifts': shifts.map((e) => e.toJson()).toList(),
    'absence': absence?.toJson(),
  };
}

@override
String toString() {
  return 'Employee{id: $id, name: $name, surname: $surname, email: $email, phone: $phone, position: $position, monthlyWorkHours: $monthlyWorkHours, shifts: $shifts, absence: ${absence.toString()}}';
}


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Employee &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          surname == other.surname &&
          email == other.email &&
          phone == other.phone &&
          position == other.position &&
          monthlyWorkHours == other.monthlyWorkHours &&
          shifts == other.shifts &&
          absence == other.absence;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      position.hashCode ^
      monthlyWorkHours.hashCode ^
      shifts.hashCode ^
      absence.hashCode;

  //copyWith method
  Employee copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? phone,
    Position? position,
    double? monthlyWorkHours,
    List<Shift>? shifts,
    Absence? absence,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      position: position ?? this.position,
      monthlyWorkHours: monthlyWorkHours ?? this.monthlyWorkHours,
      shifts: shifts ?? this.shifts,
      absence: absence ?? this.absence,
    );
  }
}