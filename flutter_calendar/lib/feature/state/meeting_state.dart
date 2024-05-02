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
  String eventName = '';
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 18, minute: 0);

  MeetingNotifier()
      : super(const CalendarMeetings(meetings: [], currentMeeting: null)) {
    _addMockMeetings();
  }

  // Metodo per aggiornare lo stato con una nuova lista di meeting
  void updateMeetings(List<Meeting> meetings) {
    // Converte la lista di meeting attuali in un set (set contiene ele unici non dupplicati).
    Set<Meeting> updatedMeetings = (state.meetings ?? []).toSet();
    // Aggiunge tutti i meeting dalla lista passata come parametro al set.
    // Se un meeting è già presente nel set, non verrà aggiunto di nuovo.
    updatedMeetings.addAll(meetings);
    // Converte il set di meeting aggiornato in una lista e aggiorna lo stato.
    state = state.copyWithMultipleMeeting(updatedMeetings.toList());
  }

  // Metodo per cambiare il meeting corrente
  void changeCurrentMeeting(Meeting newMeeting) {
    state = state.copyWithSingleMeeting(newMeeting);
  }

  // Metodo per ottenere i meeting di una data specifica
  List<Meeting> getMeetingsOnSelectedDate() {
    return state.meetings?.where((meeting) {
          return meeting.from.day == selectedDate.day &&
              meeting.from.month == selectedDate.month &&
              meeting.from.year == selectedDate.year;
        }).toList() ??
        [];
  }


  // Metodo per creare un meeting:
  void createMeeting() {
    Meeting newMeeting = Meeting(
      eventName,
      DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startTime.hour,
        startTime.minute,
      ),
      DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        endTime.hour,
        endTime.minute,
      ),
      Colors.purpleAccent,
      false,
    );

    addMeeting(newMeeting);
  }

  // Metodo per aggiungere un meeting
  void addMeeting(Meeting newMeeting) {
    List<Meeting> updatedMeetings = state.meetings ?? [];
    updatedMeetings.add(newMeeting);
    state = state.copyWithMultipleMeeting(updatedMeetings);
  }

  // Metodo per selezionare il giorno cliccato
  // per aggiungere poi il meeting
  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
  }

  // Metodo per ottenere i meeting di una data specifica
  List<Meeting> getMeetingsOnDate(DateTime date) {
    return state.meetings?.where((meeting) {
          return meeting.from.day == date.day &&
              meeting.from.month == date.month &&
              meeting.from.year == date.year;
        }).toList() ??
        [];
  }

  // Metodo per aggiungere i dati mock
  void _addMockMeetings() {
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    List<Meeting> mockMeetings = [
      Meeting(
          'Conference 1', startTime, endTime, const Color(0xFF0F8644), false),
      Meeting('Conference 1.1', startTime, endTime, Colors.red, false),
      Meeting('Conference 1.2', startTime, endTime, Colors.grey, false),
      Meeting('Conference 1.3', startTime, endTime, Colors.blue, false),
      Meeting('Conference 1.4', startTime, endTime, Colors.purpleAccent, false),
      Meeting(
          'Conference 2',
          startTime.add(const Duration(days: 1)),
          endTime.add(const Duration(days: 1)),
          const Color.fromARGB(255, 246, 10, 222),
          false),
      Meeting(
          'Conference 3',
          startTime.add(const Duration(days: 10)),
          endTime.add(const Duration(days: 10)),
          const Color.fromARGB(255, 250, 246, 25),
          false),
    ];
    state = state.copyWithMultipleMeeting(mockMeetings);
  }
}
