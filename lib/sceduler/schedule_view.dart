import 'dart:async';
import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../call_provider.dart';
import 'model/absence.dart';
import 'model/employee.dart';
import 'model/postition.dart';
import 'model/shift.dart';
import 'providers/employee_provider.dart';

class ScheduleView extends ConsumerStatefulWidget {
  const ScheduleView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends ConsumerState<ScheduleView>
    with TickerProviderStateMixin {
  DateTime selectedMonth = DateTime.now();
  List<Employee> visibleUsers = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool isScrolling1 = false;
  bool isScrolling2 = false;
  int? foundUserIndex;

  late AnimationController? _colorAnimationController;

  late Animation<Color?> _colorTweenAnimation;
  _generateEmployees(int count) {
    List<Employee> users = [];
    for (var i = 0; i < count; i++) {
      String name = _fetchRandomName();
      String surname = _getRandomSurname();
      String phone = _generateRandomPhoneNumber();
      int shiftsCount = Random().nextInt(3) + 5;
      users.add(Employee(
        id: i.toString(),
        name: _fetchRandomName(),
        surname: _getRandomSurname(),
        email: '$name.$surname@email.com',
        phone: phone,
        position: Position(
          id: i.toString(),
          description: 'operator',
        ),
        monthlyWorkHours: 180,

        shifts: [..._generateEmployeeShiftsPerMonth(3, shiftsCount, 9)],
      ));
    }
    ref.read(employeeProvider.notifier).replaceAll(users);
  }

  String _generateRandomPhoneNumber() {
    var random = Random();
    String numbers = '0123456789';
    String number = '+371';
    for (var i = 0; i < 8; i++) {
      var randomIndex = random.nextInt(numbers.length);
      number += numbers[randomIndex];
    }
    return number;
  }

 
  String getWeekdayName(DateTime date) {
    List<String> weekdays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
    // The weekday property returns an int from 1 (Monday) to 7 (Sunday)
    return weekdays[date.weekday - 1];
  }

  final AutoScrollController _controller = AutoScrollController();

 

  var names = {
    "01-01": ["Laimnesis", "Solvita", "Solvija"],
    "01-02": ["Indulis", "Ivo", "Iva", "Ivis"],
    "01-03": ["Miervaldis", "Miervalda", "Ringolds"],
    "01-04": ["Spodra", "Ilva", "Ilvita"],
    "01-05": ["Sīmanis", "Zintis"],
    "01-06": ["Spulga", "Arnita"],
    "01-07": ["Rota", "Zigmārs", "Juliāns", "Digmārs"],
    "01-08": ["Gatis", "Ivanda"],
    "01-09": ["Kaspars", "Aksels", "Alta"],
    "01-10": ["Tatjana", "Dorisa"],
    "01-11": ["Smaida", "Franciska"],
    "01-12": ["Reinis", "Reina", "Reinholds", "Renāts"],
    "01-13": ["Harijs", "Ārijs", "Āris", "Aira"],
    "01-14": ["Roberts", "Roberta", "Raitis", "Raits"],
    "01-15": ["Fēlikss", "Felicita"],
    "01-16": ["Lidija", "Lida"],
    "01-17": ["Tenis", "Dravis"],
    "01-18": ["Antons", "Antis", "Antonijs"],
    "01-19": ["Andulis", "Alnis"],
    "01-20": ["Oļģerts", "Orests", "Aļģirds", "Aļģis"],
    "01-21": ["Agnese", "Agnija", "Agne"],
    "01-22": ["Austris"],
    "01-23": ["Grieta", "Strauta", "Rebeka"],
    "01-24": ["Krišs", "Ksenija", "Eglons", "Egle"],
    "01-25": ["Zigurds", "Sigurds", "Sigvards"],
    "01-26": ["Ansis", "Agnis", "Agneta"],
    "01-27": ["Ilze", "Ildze", "Izolde"],
    "01-28": ["Kārlis", "Spodris"],
    "01-29": ["Aivars", "Valērijs"],
    "01-30": ["Tīna", "Valentīna", "Pārsla"],
    "01-31": ["Tekla", "Violeta"],
    "02-01": ["Brigita", "Indra", "Indars", "Indris"],
    "02-02": ["Spīdola", "Sonora"],
    "02-03": ["Aīda", "Ida", "Vida"],
    "02-04": ["Daila", "Veronika", "Dominiks"],
    "02-05": ["Agate", "Selga", "Silga", "Sinilga"],
    "02-06": ["Dace", "Dārta", "Dora"],
    "02-07": ["Nelda", "Rihards", "Ričards", "Rišards"],
    "02-08": ["Aldona", "Česlavs"],
    "02-09": ["Simona", "Apolonija"],
    "02-10": ["Paulīne", "Paula", "Jasmīna"],
    "02-11": ["Laima", "Laimdota"],
    "02-12": ["Karlīna", "Līna"],
    "02-13": ["Malda", "Melita"],
    "02-14": ["Valentīns"],
    "02-15": ["Alvils", "Olafs", "Aloizs", "Olavs"],
    "02-16": ["Jūlija", "Džuljeta"],
    "02-17": ["Donats", "Konstance"],
    "02-18": ["Kora", "Kintija"],
    "02-19": ["Zane", "Zuzanna"],
    "02-20": ["Vitauts", "Smuidra", "Smuidris"],
    "02-21": ["Eleonora", "Ariadne"],
    "02-22": ["Ārija", "Rigonda", "Adrians", "Adriāna", "Adrija"],
    "02-23": ["Haralds", "Almants"],
    "02-24": ["Diāna", "Dina", "Dins"],
    "02-25": ["Alma", "Annemarija"],
    "02-26": ["Evelīna", "Aurēlija", "Mētra"],
    "02-27": ["Līvija", "Līva", "Andra"],
    "02-28": ["Skaidrīte", "Justs", "Skaidra"],
    "03-01": ["Ivars", "Ilgvars"],
    "03-02": ["Lavīze", "Luīze", "Laila"],
    "03-03": ["Tālis", "Tālavs", "Marts"],
    "03-04": ["Alise", "Auce", "Enija"],
    "03-05": ["Austra", "Aurora"],
    "03-06": ["Vents", "Centis", "Gotfrīds"],
    "03-07": ["Ella", "Elmīra"],
    "03-08": ["Dagmāra", "Marga", "Margita"],
    "03-09": ["Ēvalds"],
    "03-10": ["Silvija", "Laimrota", "Liliāna"],
    "03-11": ["Konstantīns", "Agita"],
    "03-12": ["Aija", "Aiva", "Aivis"],
    "03-13": ["Ernests", "Balvis"],
    "03-14": ["Matilde", "Ulrika"],
    "03-15": ["Amilda", "Amalda", "Imalda"],
    "03-16": ["Guntis", "Guntars", "Guntris"],
    "03-17": ["Ģertrūde", "Gerda"],
    "03-18": ["Ilona", "Adelīna"],
    "03-19": ["Jāzeps", "Juzefa"],
    "03-20": ["Made", "Irbe"],
    "03-21": ["Una", "Unigunde", "Dzelme", "Benedikts", "Benedikta"],
    "03-22": ["Tamāra", "Dziedra", "Gabriels", "Gabriela"],
    "03-23": ["Mirdza", "Žanete", "Žanna"],
    "03-24": ["Kazimirs", "Izidors"],
    "03-25": ["Māra", "Mārīte", "Marita", "Mare"],
    "03-26": ["Eiženija", "Ženija"],
    "03-27": ["Gustavs", "Gusts", "Tālrīts"],
    "03-28": ["Gunta", "Ginta", "Gunda"],
    "03-29": ["Aldonis", "Agija"],
    "03-30": ["Nanija", "Ilgmārs"],
    "03-31": ["Gvido", "Atvars"],
    "04-01": ["Dagnis", "Dagne"],
    "04-02": ["Irmgarde"],
    "04-03": ["Daira", "Dairis", "Daiva"],
    "04-04": ["Valda", "Herta", "Ārvalda", "Ārvalds", "Ārvaldis"],
    "04-05": ["Vija", "Vidaga", "Aivija"],
    "04-06": ["Zinta", "Vīlips", "Filips", "Dzinta"],
    "04-07": ["Zina", "Zinaīda", "Helmuts"],
    "04-08": ["Edgars", "Danute", "Dana", "Dans"],
    "04-09": ["Valērija", "Žubīte", "Alla"],
    "04-10": ["Anita", "Anitra", "Zīle", "Annika"],
    "04-11": ["Hermanis", "Vilmārs"],
    "04-12": ["Jūlijs", "Ainis"],
    "04-13": ["Egils", "Egīls", "Nauris"],
    "04-14": ["Strauja", "Gudrīte"],
    "04-15": ["Aelita", "Gastons"],
    "04-16": ["Mintauts", "Alfs", "Bernadeta"],
    "04-17": ["Rūdolfs", "Viviāna", "Rūdis"],
    "04-18": ["Laura", "Jadviga"],
    "04-19": ["Vēsma", "Fanija"],
    "04-20": ["Mirta", "Ziedīte"],
    "04-21": ["Marģers", "Anastasija"],
    "04-22": ["Armands", "Armanda"],
    "04-23": ["Jurģis", "Juris", "Georgs"],
    "04-24": ["Visvaldis", "Nameda", "Ritvaldis"],
    "04-25": ["Līksma", "Bārbala"],
    "04-26": ["Alīna", "Sandris", "Rūsiņš"],
    "04-27": ["Tāle", "Raimonda", "Raina", "Klementīne"],
    "04-28": ["Gundega", "Terēze"],
    "04-29": ["Vilnis", "Raimonds", "Laine"],
    "04-30": ["Lilija", "Liāna"],
    "05-01": ["Ziedonis"],
    "05-02": ["Zigmunds", "Sigmunds", "Zigismunds"],
    "05-03": ["Gints", "Uvis"],
    "05-04": ["Vizbulīte", "Viola", "Vijolīte"],
    "05-05": ["Ģirts", "Ģederts"],
    "05-06": ["Gaidis", "Didzis"],
    "05-07": ["Henriete", "Henrijs", "Jete", "Enriko"],
    "05-08": ["Staņislavs", "Staņislava", "Stefānija"],
    "05-09": ["Klāvs", "Einārs", "Ervīns"],
    "05-10": ["Maija", "Paija"],
    "05-11": ["Milda", "Karmena", "Manfreds"],
    "05-12": ["Valija", "Ināra", "Ina", "Inārs"],
    "05-13": ["Irēna", "Irīna", "Ira", "Iraīda"],
    "05-14": ["Krišjānis", "Elfa", "Aivita", "Elvita"],
    "05-15": ["Sofija", "Taiga", "Airita", "Arita"],
    "05-16": ["Edvīns", "Edijs"],
    "05-17": ["Herberts", "Dailis", "Umberts"],
    "05-18": ["Inese", "Inesis", "Ēriks"],
    "05-19": ["Lita", "Sibilla", "Teika"],
    "05-20": ["Venta", "Salvis", "Selva"],
    "05-21": ["Ernestīne", "Ingmārs", "Akvelīna"],
    "05-23": ["Leontīne", "Leokādija", "Lonija", "Ligija"],
    "05-24": ["Ilvija", "Marlēna", "Ziedone"],
    "05-25": ["Anšlavs", "Junora"],
    "05-26": ["Edvards", "Edvarts", "Eduards", "Varis"],
    "05-27": ["Dzidra", "Gunita", "Loreta", "Dzidris"],
    "05-28": ["Vilis", "Vilhelms"],
    "05-29": ["Maksis", "Maksims", "Raivis", "Raivo"],
    "05-30": ["Vitolds", "Lolita", "Letīcija"],
    "05-31": ["Alīda", "Jūsma"],
    "06-01": ["Biruta", "Mairita", "Bernedīne"],
    "06-02": ["Lība", "Emma"],
    "06-03": ["Inta", "Ineta", "Intra"],
    "06-04": ["Elfrīda", "Sintija", "Sindija"],
    "06-05": ["Igors", "Margots", "Ingvars"],
    "06-06": ["Ingrīda", "Ardis"],
    "06-07": ["Gaida", "Arnis", "Arno"],
    "06-08": ["Frīdis", "Frīda", "Mundra"],
    "06-09": ["Ligita", "Gita"],
    "06-10": ["Malva", "Anatols", "Anatolijs"],
    "06-11": ["Ingus", "Mairis", "Vidvuds"],
    "06-12": ["Nora", "Lenora", "Ija"],
    "06-13": ["Zigfrīds", "Ainārs", "Uva"]
  };

  String surnameInitials = 'ABCDEFGHIJKLMNOPRSTUVZĀČĒĢĪĶĻŅŠŪŽ';
  String _fetchRandomName() {
    var random = Random();
    var randomRow = random.nextInt(names.length);
    var randomName = random.nextInt(names.values.elementAt(randomRow).length);
    return names.values.elementAt(randomRow).elementAt(randomName);
  }

  String _getRandomSurname() {
    var random = Random();
    var randomInitial = random.nextInt(surnameInitials.length);
    return surnameInitials[randomInitial];
  }

  @override
  void initState() {
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _colorTweenAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.blue,
    ).animate(_colorAnimationController!)
      ..addListener(() {
        setState(() {});
      });
    //Post frame callback to generate employees after the build method
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _generateEmployees(94);
    });

    super.initState();
  }

 List<Shift> _generateEmployeeShiftsPerMonth(int mont, int shiftCount, int maxHours) {
    var random = Random();
     List<Shift> shifts = [];
    for (var i = 0; i < shiftCount; i++) {
      var start = DateTime(2024, mont, random.nextInt(30), random.nextInt(16),
          random.nextInt(60));
      var end = start.add(Duration(hours: random.nextInt(maxHours)));
      shifts.add(Shift(
        id: i.toString(),
        start: start,
        end: end,
      ));
    }
    return shifts;
  }

  @override
  void dispose() {
    _colorAnimationController?.dispose();

    _debounce?.cancel();
    _debounce = null;
    _textEditingController.dispose();
    _controller.dispose();
    super.dispose();
  }

  _buildDateRow(int daysInMonth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 2,
            child: FittedBox(
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        setState(() {
                          selectedMonth = DateTime(
                            selectedMonth.year,
                            selectedMonth.month - 1,
                          );
                        });
                      },
                    ),
                    Text(
                      '${selectedMonth.year} - ${selectedMonth.month}',
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        setState(() {
                          selectedMonth = DateTime(
                            selectedMonth.year,
                            selectedMonth.month + 1,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              daysInMonth,
              (index) {
                return Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FittedBox(child: Text('${index + 1}')),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _bildDayRow(daysInMonth) {
    return Material(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
              flex: 2,
              child: FittedBox(
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text('Employee name'),
                  ),
                ),
              )),
          Expanded(
            flex: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: List.generate(
                daysInMonth,
                (index) {
                  DateTime dateForTile = DateTime(
                      selectedMonth.year, selectedMonth.month, index + 1);

                  String weekdayName = getWeekdayName(dateForTile);
                  return Expanded(
                    child: SizedBox(
                      height: 50,
                      child: FittedBox(
                          child: Text(
                        '$weekdayName',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: (weekdayName == 'Sa' || weekdayName == 'Su')
                                ? Colors.red
                                : Colors.black, fontSize: 16),
                      )),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  int findItemIndex(List<String> items, String query) {
    return items
        .indexWhere((item) => item.toLowerCase().contains(query.toLowerCase()));
  }

  Timer? _debounce;
  debouncer(int foundIndex) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        foundUserIndex = foundIndex;
        _colorAnimationController?.forward(from: 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final employees = ref.watch(employeeProvider);
    int daysInMonth =
        DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          height: 50,
          child: TextField(
            controller: _textEditingController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  foundUserIndex = null;
                });
                return;
              }

              int index =
                  findItemIndex(employees.map((e) => e.name).toList(), value);
              _controller.scrollToIndex(index,
                  preferPosition: AutoScrollPosition.begin);
              debouncer(index);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: _buildDateRow(daysInMonth)),
          Expanded(child: _bildDayRow(daysInMonth)),
          Expanded(
            flex: 20,
            child: ListView.builder(
              controller: _controller,
              itemCount: employees.length,
              itemBuilder: (BuildContext context, int index) {
                Employee employee = employees[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AutoScrollTag(
                        key: ValueKey(index),
                        index: index,
                        controller: _controller,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  List<DateTime?> _dates = [];
                                  return Scaffold(
                                      appBar: AppBar(
                                        title: Text('Employee details'),
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              print(_dates);
                                              Employee selectedEmployee =
                                                  employees[index];
                                              Absence absence = Absence(
                                                id: selectedEmployee.id,
                                                start: _dates[0]!,
                                                end: _dates[1]!,
                                                reason: 'Sick leave',
                                              );
                                              Employee updated =
                                                  selectedEmployee.copyWith(
                                                      absence: absence);
                                              ref
                                                  .read(
                                                      employeeProvider.notifier)
                                                  .updateEmployee(updated);
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.save),
                                          ),
                                        ],
                                      ),
                                      body: Container(
                                        color: Colors.white,
                                        child: CalendarDatePicker2(
                                          config: CalendarDatePicker2Config(
                                            calendarType:
                                                CalendarDatePicker2Type.range,
                                          ),
                                          value: _dates,
                                          onValueChanged: (dates) =>
                                              _dates = dates,
                                        ),
                                      ));
                                });
                          },
                          child: Material(
                            color: foundUserIndex == index
                                ? _colorTweenAnimation.value
                                : Colors.white,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '${index + 1}: ${employee.name} ${employee.surname}.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: GridView.count(
                        crossAxisCount: daysInMonth,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        shrinkWrap: true,
                        children: List.generate(
                          daysInMonth,
                          (int index) {
                            // Create a DateTime object for each day in the grid
                            DateTime currentDate = DateTime(selectedMonth.year,
                                selectedMonth.month, index + 1);

                            // Check if the current day is within the absence range
                            bool isAbsent = employee.absence != null &&
                                currentDate
                                        .compareTo(employee.absence!.start) >=
                                    0 &&
                                currentDate.compareTo(employee.absence!.end) <=
                                    0;

                            if (isAbsent) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 100),
                                columnCount: daysInMonth,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.amber,
                                    ),
                                  )),
                                ),
                              );
                            } else {
                              //Check if the current day is within the shift range
                              Shift? matchingShift = employee.shifts
                                  .firstWhereOrNull((shift) =>
                                      currentDate.year == shift.start.year &&
                                      currentDate.month == shift.start.month &&
                                      currentDate.day == shift.start.day);

                              String tileText = matchingShift != null
                                  ? '${matchingShift.start.hour}'
                                  : '';

                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 100),
                                columnCount: daysInMonth,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      child: Center(
                                        child:
                                            FittedBox(child: Text('$tileText')),
                                      ),
                                    ),
                                  )),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
