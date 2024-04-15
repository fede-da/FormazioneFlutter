import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';

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

// MeetingNotifier è una classe che estende StateNotifier.
// Gestisce lo stato dei meeting e fornisce un metodo per aggiornare lo stato.
class MeetingNotifier extends StateNotifier<CalendarMeetings> {
  // Inizializziamo lo stato come una lista vuota di meeting.
  MeetingNotifier()
      : super(const CalendarMeetings(meetings: [], currentMeeting: null));

  // Questo metodo permette di aggiornare lo stato con una nuova lista di meeting.
  void updateMeetings(List<Meeting> meetings) {
    state.copyWithMultipleMeeting(meetings);
  }

  void onNewMeetingSelected(CalendarMeetings newCalendarMeeting) {
    state = newCalendarMeeting;
  }

  void changeCurrentMeeting(Meeting newMeeting) {
    state.copyWithSingleMeeting(newMeeting);
  }
}
