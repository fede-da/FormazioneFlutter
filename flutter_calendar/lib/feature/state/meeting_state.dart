import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';

// Provider per il MeetingNotifier.
// Ci permette di accedere allo stato dei meeting in qualsiasi punto dell'app.
final meetingProvider =
    StateNotifierProvider<MeetingNotifier, List<Meeting>>((ref) {
  return MeetingNotifier();
});

// MeetingNotifier è una classe che estende StateNotifier.
// Gestisce lo stato dei meeting e fornisce un metodo per aggiornare lo stato.
class MeetingNotifier extends StateNotifier<List<Meeting>> {
  // Inizializziamo lo stato come una lista vuota di meeting.
  MeetingNotifier() : super([]);

  // Questo metodo permette di aggiornare lo stato con una nuova lista di meeting.
  void updateMeetings(List<Meeting> meetings) {
    state = meetings;
  }
}
