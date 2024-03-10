import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/employee.dart';

final employeeProvider = NotifierProvider<EmployeeProvider, List<Employee>>(() => EmployeeProvider());


class EmployeeProvider extends Notifier<List<Employee>> {

  void addEmployee(Employee employee){
    state = [...state, employee];
  }

  void removeEmployee(Employee employee){
    state = state.where((element) => element != employee).toList();
  }

  void addAll(List<Employee> employees){
    state = [...state, ...employees];
  }

  void replaceAll(List<Employee> employees){
    state = employees;
  }

  void updateEmployee(Employee employee){
    print(employee.toString());
    state = state.map((e) => e.id == employee.id ? employee : e).toList();
  }

  @override
  List<Employee> build() {
    return [];
  }

  
}
