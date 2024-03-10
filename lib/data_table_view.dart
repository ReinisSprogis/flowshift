import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataTableView extends ConsumerStatefulWidget {
  const DataTableView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DataTableViewState();
}

class _DataTableViewState extends ConsumerState<DataTableView> {
   DateTime selectedMonth = DateTime.now();

  final ScrollController listController = ScrollController();
  final ScrollController gridController = ScrollController();
  bool isScrolling1 = false;
  bool isScrolling2 = false;
  String getWeekdayName(DateTime date) {
    List<String> weekdays = ["P", "O", "T", "C", "Pk", "S", "Sv"];
    // The weekday property returns an int from 1 (Monday) to 7 (Sunday)
    return weekdays[date.weekday - 1];
  }

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
    "05-22": ["Emīlija", "Visu neparasto un kalendāros neierakstīto vārdu diena"],
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
    "06-13": ["Zigfrīds", "Ainārs", "Uva"]};


  //Fetch random row from names map, then random name from that row
  String _fetchRandomName(){
    var random = Random();
    var randomRow = random.nextInt(names.length);
    var randomName = random.nextInt(names.values.elementAt(randomRow).length);
    return names.values.elementAt(randomRow).elementAt(randomName);
  }

  @override
  Widget build(BuildContext context) {
     int daysInMonth =
        DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
    int rowCount = 90;


    return Scaffold(
      body: FittedBox(
        fit: BoxFit.fitWidth,
        child: DataTable(
          columns:  <DataColumn>[
           const DataColumn(
              label: Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
           
           ...List.generate(daysInMonth, (index) {
              return DataColumn(
                label: Expanded(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              );
            }),
          ],
          rows:  <DataRow>[
           ...List.generate(rowCount, (index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text('$index: ${_fetchRandomName()}')),
                  ...List.generate(daysInMonth, (index) {
                    return DataCell(Text('Data $index'));
                  }),
                ],
              );
            }),
           
          ],
        ),
      ),
    );
  }
}
