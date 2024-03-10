import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final callProvider =
    NotifierProvider<CallProvider, CallManager>(() => CallProvider());

enum CallType {
  incoming,
  missed,
  active,
  ended,
  rejected,
  blocked,
  voicemail,
  scheduled,
}

enum UserType {
  customer,
  unknown,
}

class Itenary {
  String id;
  String name;
  String destination;
  String origin;
  DateTime departureTime;
  DateTime arrivalTime;
  bool isDelayed;
  bool isCancelled;
  bool isScheduled;
  bool isCompleted;
  bool isOnTime;
  bool isDeparted;

  Itenary(
      {required this.id,
      required this.name,
      required this.destination,
      required this.origin,
      required this.departureTime,
      required this.arrivalTime,
      required this.isDelayed,
      required this.isCancelled,
      required this.isScheduled,
      required this.isCompleted,
      required this.isOnTime,
      required this.isDeparted});

  Itenary copyWith({
    String? id,
    String? name,
    String? destination,
    String? origin,
    DateTime? departureTime,
    DateTime? arrivalTime,
    bool? isDelayed,
    bool? isCancelled,
    bool? isScheduled,
    bool? isCompleted,
    bool? isOnTime,
    bool? isDeparted,
  }) {
    return Itenary(
      id: id ?? this.id,
      name: name ?? this.name,
      destination: destination ?? this.destination,
      origin: origin ?? this.origin,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      isDelayed: isDelayed ?? this.isDelayed,
      isCancelled: isCancelled ?? this.isCancelled,
      isScheduled: isScheduled ?? this.isScheduled,
      isCompleted: isCompleted ?? this.isCompleted,
      isOnTime: isOnTime ?? this.isOnTime,
      isDeparted: isDeparted ?? this.isDeparted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Itenary &&
        other.id == id &&
        other.name == name &&
        other.destination == destination &&
        other.origin == origin &&
        other.departureTime == departureTime &&
        other.arrivalTime == arrivalTime &&
        other.isDelayed == isDelayed &&
        other.isCancelled == isCancelled &&
        other.isScheduled == isScheduled &&
        other.isCompleted == isCompleted &&
        other.isOnTime == isOnTime &&
        other.isDeparted == isDeparted;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      destination.hashCode ^
      origin.hashCode ^
      departureTime.hashCode ^
      arrivalTime.hashCode ^
      isDelayed.hashCode ^
      isCancelled.hashCode ^
      isScheduled.hashCode ^
      isCompleted.hashCode ^
      isOnTime.hashCode ^
      isDeparted.hashCode;
}

class User {
  String id;
  String name;
  UserType userType;
  String phoneNumber;
  String email;
  String profileImage;
  List<Itenary> itenaries;
  User(
      {required this.id,
      required this.name,
      required this.userType,
      required this.phoneNumber,
      required this.email,
      required this.profileImage,
      required this.itenaries});

  static List<String> itenaryNames() {
    return [
      'ABZ',
      'AGA',
      'ALC',
      'AMS',
      'ARN',
      'ATH',
      'BCN',
      'BEG',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD',
      'BGO',
      'BHX',
      'BLL',
      'BOJ',
      'BRE',
      'BRI',
      'BRS',
      'BRU',
      'BUD'
    ];
  }

  User copyWith({
    String? id,
    String? name,
    UserType? userType,
    String? phoneNumber,
    String? email,
    String? profileImage,
    List<Itenary>? itenaries,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      itenaries: itenaries ?? this.itenaries,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.userType == userType &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.profileImage == profileImage &&
        other.itenaries == itenaries;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      userType.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      itenaries.hashCode;
}

@immutable
class Call {
  final String id;
  final String callTime;
  final String callTimeDifference;
  final CallType callType;
  final bool isScheduled;
  final DateTime callDateTime;
  final Duration callDuration;
  final DateTime? scheduledTime;
  final User? user;
  const Call(
      {required this.id,
      required this.callTime,
      required this.callTimeDifference,
      required this.callType,
      required this.isScheduled,
      required this.callDateTime,
      required this.callDuration,
      required this.user,
      this.scheduledTime
      });

  //CopyWith method
  Call copyWith({
    String? id,
    String? callTime,
    String? callTimeDifference,
    CallType? callType,
    bool? isScheduled,
    DateTime? callDateTime,
    Duration? callDuration,
    User? user,
    DateTime? scheduledTime,
  }) {
    return Call(
      id: id ?? this.id,
      callTime: callTime ?? this.callTime,
      callTimeDifference: callTimeDifference ?? this.callTimeDifference,
      callType: callType ?? this.callType,
      isScheduled: isScheduled ?? this.isScheduled,
      callDateTime: callDateTime ?? this.callDateTime,
      callDuration: callDuration ?? this.callDuration,
      user: user ?? this.user,
      scheduledTime: scheduledTime ?? this.scheduledTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Call &&
        other.id == id &&
        other.callTime == callTime &&
        other.callTimeDifference == callTimeDifference &&
        other.callType == callType &&
        other.isScheduled == isScheduled &&
        other.callDateTime == callDateTime &&
        other.callDuration == callDuration &&
        other.user == user
        && other.scheduledTime == scheduledTime;
  }

  @override
  int get hashCode =>
      callTime.hashCode ^
      callTimeDifference.hashCode ^
      id.hashCode ^
      callType.hashCode ^
      isScheduled.hashCode ^
      callDateTime.hashCode ^
      callDuration.hashCode ^
      user.hashCode
      ^ scheduledTime.hashCode;

  //toString method
  @override
  String toString() {
    return 'Call{id: $id, callTime: $callTime, callTimeDifference: $callTimeDifference, callType: $callType, isScheduled: $isScheduled, callDateTime: $callDateTime, callDuration: $callDuration, user: $user, scheduledTime: $scheduledTime}';
  }
}

@immutable
class CallManager {
  final List<Call> incomingCalls;
  final List<Call> scheduledCalls;

  const CallManager({
    required this.incomingCalls,
    required this.scheduledCalls,
  });

  //copyWith method
  CallManager copyWith({
    List<Call>?  incomingCalls,
    List<Call>? scheduledCalls,
  }) {
    return CallManager(
      incomingCalls: incomingCalls  ?? this.incomingCalls,
      scheduledCalls: scheduledCalls ?? this.scheduledCalls,
    );
  }
}

class CallProvider extends Notifier<CallManager> {
  CallProvider();

  _getCallTimeDifference(DateTime callTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(callTime);
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return '${difference.inSeconds} seconds ago';
    }
  }

  //Generate random call.
  //Simulation of actual call.
  //Call time is generated randomly between 1-5 minutes ago
  //Call duration is not generated
  //Call type is generated randomly
  //User is generated randomly
  //Call is added to the list of calls
  void generateRandomCall() {
    DateTime now = DateTime.now();
    Random random = Random();
    List<CallType> randomCallType = [
      CallType.incoming,
      CallType.missed,
      CallType.rejected,
      CallType.voicemail,
      CallType.scheduled
      ];
    int randomMinutes = random.nextInt(5);
    DateTime callTime = now.subtract(Duration(minutes: randomMinutes));
    String callTimeDifference = _getCallTimeDifference(callTime);
    String callTimeStr = callTime.toString();
    CallType callType = [CallType.incoming, CallType.scheduled][random.nextInt(2)];
    bool isScheduled = callType == CallType.scheduled ? true : false;
    DateTime? scheduledTime = isScheduled ? callTime.add(Duration(minutes: random.nextInt(1000))) : null;
    
    User user = User(
        id: random.nextInt(100).toString(),
        name: 'User: ${random.nextInt(100)}',
        userType: isScheduled ? UserType.customer : UserType.values[random.nextInt(UserType.values.length)],
        phoneNumber: '0${random.nextInt(1000000000)}',
        email: 'user${random.nextInt(100)}@gmail.com',
        profileImage: 'https://wwww.example.com/user${random.nextInt(100)}.png',
        itenaries: [
          Itenary(
              id: random.nextInt(100).toString(),
              name: User.itenaryNames()[random.nextInt(User.itenaryNames().length)],
              destination: User.itenaryNames()[random.nextInt(User.itenaryNames().length)],
              origin:  User.itenaryNames()[random.nextInt(User.itenaryNames().length)],
              departureTime: DateTime.now().add(Duration(minutes: random.nextInt(1000000))),
              arrivalTime: now.add(Duration(minutes: random.nextInt(100))),
              isDelayed: random.nextBool(),
              isCancelled: random.nextBool(),
              isScheduled: random.nextBool(),
              isCompleted: random.nextBool(),
              isOnTime: random.nextBool(),
              isDeparted: random.nextBool())
        ]);

    Call call = Call(
        id: random.nextInt(100).toString(),
        callTime: callTimeStr,
        callTimeDifference: callTimeDifference,
        callType: callType,
        isScheduled: isScheduled,
        callDateTime: callTime,
        scheduledTime: scheduledTime,
        callDuration: Duration(seconds: random.nextInt(1000)),
        user: user);

    if(callType == CallType.scheduled){
      addScheduledCall(call);
    }else{
      addIncomingCall(call);
    }
  }

  addIncomingCall(Call call) {
    state = state.copyWith(incomingCalls: [...state.incomingCalls, call]);
  }

  addScheduledCall(Call call) {
    state = state.copyWith(scheduledCalls: [...state.scheduledCalls, call]);
  }

  //Update incoming call
  //Call is replaced with new call
  void updateIncomingCall(Call call) {
    List<Call> updatedCalls = state.incomingCalls
        .map((e) => e.id == call.id ? call : e)
        .toList();
    state = state.copyWith(incomingCalls: updatedCalls);
  }

  //Update scheduled call
  //Call is replaced with new call
  void updateScheduledCall(Call call) {
    List<Call> updatedCalls = state.scheduledCalls
        .map((e) => e.id == call.id ? call : e)
        .toList();
    state = state.copyWith(scheduledCalls: updatedCalls);
  }

  //Remove call
  //Call is removed from the list of calls
  void removeCall(Call call) {
    //check if call is incoming or scheduled by id
    int index = state.incomingCalls.indexWhere((element) => element.id == call.id);
    if(index != -1){
      List<Call> updatedCalls = state.incomingCalls
          .where((element) => element.id != call.id)
          .toList();
      state = state.copyWith(incomingCalls: updatedCalls);

    }else{
      List<Call> updatedCalls = state.scheduledCalls
          .where((element) => element.id != call.id)
          .toList();
      state = state.copyWith(scheduledCalls: updatedCalls);
    }

  }

  //pick up call changing call type to
  @override
  CallManager build() {
    return CallManager(incomingCalls: const [], scheduledCalls: const []);
  }
}
