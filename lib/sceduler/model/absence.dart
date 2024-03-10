import 'package:flutter/foundation.dart';

@immutable
class Absence{
final String id;
final DateTime start;
final DateTime end;
final String reason;

Absence({
  required this.id,
  required this.start,
  required this.end,
  required this.reason,
});


factory Absence.fromJson(Map<String, dynamic> json) {
  return Absence(
    id: json['id'],
    start: DateTime.parse(json['start']),
    end: DateTime.parse(json['end']),
    reason: json['reason'],
  );
}


Map<String, dynamic> toJson() {
  return {
    'id': id,
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
    'reason': reason,
  };
}

@override
String toString() {
  return 'Absence{id: $id, start: $start, end: $end, reason: $reason,';

}

@override
bool operator ==(Object other) =>
    identical(this, other) ||
    other is Absence &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        start == other.start &&
        end == other.end &&
        reason == other.reason;

@override
int get hashCode =>
    id.hashCode ^
    start.hashCode ^
    end.hashCode ^
    reason.hashCode;

//copyWith method
Absence copyWith({
  String? id,
  DateTime? start,
  DateTime? end,
  String? reason,
}) {
  return Absence(
    id: id ?? this.id,
    start: start ?? this.start,
    end: end ?? this.end,
    reason: reason ?? this.reason,
  );

}
}