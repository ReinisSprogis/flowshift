import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

import 'call_provider.dart';
import 'sceduler/model/employee.dart';
import 'sceduler/model/postition.dart';
import 'sceduler/model/shift.dart';
import 'sceduler/providers/employee_provider.dart';
import 'sceduler/providers/shift_provider.dart';
import 'sceduler/sceduler.dart';
import 'sceduler/schedule_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MaterialColor _primaryColor =
      MaterialColor(const Color(0xFFcdda32).value, const <int, Color>{
    50: Color(0xFFcdda32),
    100: Color(0xFFcdda32),
    200: Color(0xFFcdda32),
    300: Color(0xFFcdda32),
    400: Color(0xFFcdda32),
    500: Color(0xFFcdda32),
    600: Color(0xFFcdda32),
    700: Color(0xFFcdda32),
    800: Color(0xFFcdda32),
    900: Color(0xFFcdda32),
  });
  final Color _secondaryColor = const Color(0xFF152649);
  ThemeData appTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: _primaryColor, accentColor: _secondaryColor));
  runApp(ProviderScope(
      child: MaterialApp(
    theme: appTheme,
    home: const Scheduler(),
  )));
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final employees = ref.watch(employeeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('flo'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('Employees'),
                    onTap: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Scaffold(
                              body: Column(
                                children: [
                                  const Card(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          labelText: 'Name',
                                          fillColor: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(employeeProvider.notifier)
                                            .addEmployee(Employee(
                                                name: 'John Doe',
                                                id: employees.length.toString(),
                                                phone: '12345678',
                                                email: 'Reinssprogis@gmail.com',
                                                position: Position(
                                                    id: '1',
                                                    description: 'call_agent'),
                                                surname: 'Doe',
                                                monthlyWorkHours: 160,
                                                shifts: const []));
                                      },
                                      child: const Text('Add'))
                                ],
                              ),
                            );
                          });
                    },
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(employees[index].name),
                        );
                      }),
                      itemCount: employees.length,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Scheduler()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Shift shift = Shift(
                id: '1',
                start: DateTime.now(),
                end: DateTime.now().add(const Duration(hours: 8)),
                );
            ref.read(shiftProvider.notifier).addShift(shift);
          },
          child: const Icon(Icons.phone),
        ));
  }
}

class CallManager extends ConsumerStatefulWidget {
  const CallManager({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallManagerState();
}

class _CallManagerState extends ConsumerState<CallManager> {
  late Stream callStream;
  late StreamSubscription callSubscription;
  Call? currentCall;

  _pickUpCall(Call call) {
    Call pickUpCall = call.copyWith(callType: CallType.active);
    ref.read(callProvider.notifier).updateIncomingCall(pickUpCall);
    currentCall = pickUpCall;
  }

  _dropCall(Call call) {
    Call dropCall = call.copyWith(callType: CallType.ended);
    ref.read(callProvider.notifier).removeCall(dropCall);
    currentCall = null;
  }

  @override
  void initState() {
    super.initState();
    callStream = Stream.periodic(const Duration(seconds: 5), (x) {
      ref.read(callProvider.notifier).generateRandomCall();
    });
    callSubscription = callStream.listen((event) {});
  }

  @override
  void dispose() {
    callSubscription.cancel();
    super.dispose();
  }

  final MaterialColor _primaryColor =
      MaterialColor(const Color(0xFFcdda32).value, const <int, Color>{
    50: Color(0xFFcdda32),
    100: Color(0xFFcdda32),
    200: Color(0xFFcdda32),
    300: Color(0xFFcdda32),
    400: Color(0xFFcdda32),
    500: Color(0xFFcdda32),
    600: Color(0xFFcdda32),
    700: Color(0xFFcdda32),
    800: Color(0xFFcdda32),
    900: Color(0xFFcdda32),
  });
  final Color _secondaryColor = const Color(0xFF152649);

  DateTime _getCallTime() {
    DateTime now = DateTime.now();
    Random random = Random();
    int randomMinutes = random.nextInt(5);
    DateTime callTime = now.subtract(Duration(minutes: randomMinutes));

    return callTime;
  }

  //Get time difference between current time and call time
  String _getCallTimeDifference(DateTime callTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(callTime);
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return '${difference.inSeconds} seconds ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final callsList = ref.watch(callProvider);
    return Scaffold(
        appBar: AppBar(
          actions: const [
            //profile photo and name
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right:8.0),
                  child: Text(
                    'John Doe',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: _primaryColor,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: _secondaryColor,
                        child: Center(
                            child: Text(
                          'Scheduled calls: ${callsList.scheduledCalls.length}',
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                    callsList.scheduledCalls.isNotEmpty
                        ? Expanded(
                            child: ImplicitlyAnimatedList(
                                itemData: callsList.scheduledCalls,
                                itemBuilder: (context, call) {
                                  callsList.scheduledCalls.sort((a, b) =>
                                      a.scheduledTime!.compareTo(b.scheduledTime!));
                                  return Material(
                                    elevation: 2,
                                    color: Colors.white,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                        tileColor: Colors.white,
                                        leading: IconButton.filled(
                                            onPressed: () {
                                              if ((currentCall != null &&
                                                  call.id == currentCall?.id)) {
                                                _dropCall(call);
                                              } else {
                                                _pickUpCall(call);
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Scaffold(
                                                          appBar: AppBar(
                                                        title: const Text(
                                                            'Call details'),
                                                        leading:
                                                            IconButton.filled(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .red)),
                                                          onPressed: () {
                                                            _dropCall(call);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons
                                                                  .phone_in_talk,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ));
                                                    });
                                              }
                                            },
                                            icon: Icon(
                                              (currentCall != null &&
                                                      call.id ==
                                                          currentCall?.id)
                                                  ? Icons.phone_in_talk
                                                  : Icons.phone,
                                              color: (currentCall != null &&
                                                      call.id ==
                                                          currentCall?.id)
                                                  ? Colors.red
                                                  : _secondaryColor,
                                            )),
                                        title: Text(
                                            '${call.user?.itenaries.first.name} ->  ${call.user?.itenaries.first.destination} : ${call.user!.itenaries.first.departureTime.month}/${call.user!.itenaries.first.departureTime.day}-${call.user!.itenaries.first.departureTime.hour}:${call.user!.itenaries.first.departureTime.minute} '),
                                        trailing: Text(
                                          '${call.scheduledTime!.hour}:${call.scheduledTime!.minute} ',
                                        )),
                                  );
                                }),
                          )
                        : const Center(
                            child: Text(
                              'No calls',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ],
                )),
              ),
            ),
            Expanded(
              child: Container(
                color: _secondaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: _primaryColor,
                        child: Center(
                            child: Text(
                          'Incoming calls: ${callsList.incomingCalls.length}',
                          style: TextStyle(
                              color: _secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    callsList.incomingCalls.isNotEmpty
                        ? Expanded(
                            child: ImplicitlyAnimatedList(
                                itemData: callsList.incomingCalls,
                                itemBuilder: (context, call) {
                                  callsList.incomingCalls.sort((a, b) =>
                                      a.callDateTime.compareTo(b.callDateTime));
                                  return Material(
                                    elevation: 2,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      trailing: Text(
                                        _getCallTimeDifference(
                                            call.callDateTime),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      leading: IconButton.filled(
                                          onPressed: () {
                                            if ((currentCall != null &&
                                                call.id == currentCall?.id)) {
                                              _dropCall(call);
                                            } else {
                                              _pickUpCall(call);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.phone,
                                            color: (currentCall != null &&
                                                    call.id == currentCall?.id)
                                                ? Colors.red
                                                : _secondaryColor,
                                          )),
                                      title: Text(
                                          '${call.user!.userType.name} ${call.callType.name}'),
                                    ),
                                  );
                                }),
                          )
                        : const Center(
                            child: Text(
                              'No calls',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(callProvider.notifier).generateRandomCall();
          },
        ));
  }
}
