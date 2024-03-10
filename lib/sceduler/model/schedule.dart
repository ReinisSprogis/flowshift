
import 'package:flutter/foundation.dart';

import 'absence.dart';
import 'shift.dart';

@immutable
class Scedule {
  final List<Shift> shifts;
  final List<Absence> absences;

  Scedule({
    required this.shifts,
    required this.absences,
  });

  factory Scedule.fromJson(Map<String, dynamic> json) {
    return Scedule(
      shifts: json['shifts'].map<Shift>((e) => Shift.fromJson(e)).toList(),
      absences: json['absences'].map<Absence>((e) => Absence.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shifts': shifts.map((e) => e.toJson()).toList(),
      'absences': absences.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Scedule{shifts: $shifts, absences: $absences,';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Scedule &&
          runtimeType == other.runtimeType &&
          shifts == other.shifts &&
          absences == other.absences;

  @override
  int get hashCode => shifts.hashCode ^ absences.hashCode;

  //copyWith method
  Scedule copyWith({
    List<Shift>? shifts,
    List<Absence>? absences,
  }) {
    return Scedule(
      shifts: shifts ?? this.shifts,
      absences: absences ?? this.absences,
    );
  }
  
}