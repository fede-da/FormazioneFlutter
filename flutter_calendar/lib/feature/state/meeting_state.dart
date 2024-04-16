import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';

// Step 1: Definizione dello stato del calendario
@immutable
class CalendarMeetings {
  const CalendarMeetings(
      {required this.meetings, required this.currentMeeting});

  final List<Meeting>? meetings;
  final Meeting? currentMeeting;

  CalendarMeetings copyWithSingleMeeting(Meeting newCurrentMeeting) {
    return CalendarMeetings(
      meetings: meetings,
      currentMeeting: newCurrentMeeting,
    );
  }

  CalendarMeetings copyWithMultipleMeeting(List<Meeting> newMeetingsList) {
    return CalendarMeetings(
      meetings: newMeetingsList,
      currentMeeting: currentMeeting,
    );
  }
}

// Step 2: Provider per il MeetingNotifier
final meetingProvider =
    StateNotifierProvider<MeetingNotifier, CalendarMeetings>((ref) {
  return MeetingNotifier();
});

// Step 3: Implementazione della classe MeetingNotifier
class MeetingNotifier extends StateNotifier<CalendarMeetings> {
  MeetingNotifier()
      : super(const CalendarMeetings(meetings: [], currentMeeting: null));

  // Metodo per aggiornare lo stato con una nuova lista di meeting
  void updateMeetings(List<Meeting> meetings) {
    state = state.copyWithMultipleMeeting(meetings);
  }

  // Metodo per cambiare il meeting corrente
  void changeCurrentMeeting(Meeting newMeeting) {
    state = state.copyWithSingleMeeting(newMeeting);
  }
}
