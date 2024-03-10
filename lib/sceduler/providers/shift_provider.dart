
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/absence.dart';
import '../model/schedule.dart';
import '../model/shift.dart';

final shiftProvider = NotifierProvider<ShiftProvider, Scedule>(()=> ShiftProvider());


class ShiftProvider extends Notifier<Scedule> {

  void addShift(Shift shift){
    state = state.copyWith(shifts: [...state.shifts, shift]);
  }

  void removeShift(Shift shift){
    state = state.copyWith(shifts: state.shifts.where((element) => element != shift).toList());
  }

  void addAbsence(Absence absence){
    state = state.copyWith(absences: [...state.absences, absence]);
  }

  void removeAbsence(Absence absence){
    state = state.copyWith(absences: state.absences.where((element) => element != absence).toList());
  }

  //update shift
  void updateShift(Shift shift){
    state = state.copyWith(shifts: state.shifts.map((e) => e.id == shift.id ? shift : e).toList());
  }

  //update absence
  void updateAbsence(Absence absence){
    state = state.copyWith(absences: state.absences.map((e) => e.id == absence.id ? absence : e).toList());
  }
  


  @override
  Scedule build() {
    return Scedule(shifts: [], absences: []);
  }

  
}