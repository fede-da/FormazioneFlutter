import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';

// Definizione dello stato del calendario
@immutable
class CalendarMeetings {
  const CalendarMeetings(
      {required this.meetings, required this.currentMeeting});

  final List<Meeting>? meetings; // Lista degli incontri.
  final Meeting? currentMeeting; // Incontri correnti.

  // Implementazione della classe MeetingNotifier.
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

// Provider per il MeetingNotifier
final meetingProvider =
    StateNotifierProvider<MeetingNotifier, CalendarMeetings>((ref) {
  return MeetingNotifier();
});

// Implementazione della classe MeetingNotifier
class MeetingNotifier extends StateNotifier<CalendarMeetings> {
  DateTime selectedDate = DateTime.now();

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

  // Metodo per aggiungere un meeting
  void addMeeting(Meeting newMeeting) {
    state = state.copyWithMultipleMeeting(
      //TODO: vedere quale 2 opzioni vada bene, se lasciare la lista o crearne un'altra
      (state.meetings ?? [])..add(newMeeting),
      //List.from(state.meetings ?? [])..add(newMeeting),
    );
  }

  //TODO: capire se serve o no:
  // Metodo per selezionare il giorno cliccato
  // per aggiungere poi il meeting
  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
  }
}
