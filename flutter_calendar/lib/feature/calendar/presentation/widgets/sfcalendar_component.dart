import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/data/datasources/meeting_data_source.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Provider per il MeetingNotifier.
// Ci permette di accedere allo stato dei meeting in qualsiasi punto dell'app.
// vado a gestire il mio model nel mio state presente qui.
final meetingProvider =
    StateNotifierProvider<MeetingNotifier, CalendarMeetings>((ref) {
  return MeetingNotifier();
});

class SfCalendarComponent extends ConsumerWidget {
  // Callback chiamata quando viene selezionato un appuntamento.
  final Function(Meeting?) onAppointmentSelected;

  const SfCalendarComponent({super.key, required this.onAppointmentSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meeting> selectedMeetings = [];

    return SfCalendar(
      view: CalendarView.month,
      // Imposta la sorgente dei dati per il calendario.
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: const MonthViewSettings(
        // Imposta la modalità di visualizzazione degli appuntamenti nel mese.
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      onTap: (CalendarTapDetails details) {
        if (details.appointments != null) {
          selectedMeetings.clear();
          // Aggiunge tutti gli appuntamenti selezionati alla lista.
          selectedMeetings
              .addAll(details.appointments!.map((e) => e as Meeting));
          // Aggiorna lo stato dei meeting con gli appuntamenti selezionati.
          ref.read(meetingProvider.notifier).updateMeetings(selectedMeetings);
          // Passa l'appuntamento selezionato alla home
          onAppointmentSelected(
              selectedMeetings.isNotEmpty ? selectedMeetings.first : null);
        }
      },
    );
  }

  // Genera una lista di appuntamenti di esempio.
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(
      Meeting(
        'Conference 1',
        startTime,
        endTime,
        const Color(0xFF0F8644),
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.1',
        startTime,
        endTime,
        Colors.purpleAccent,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 2',
        startTime.add(const Duration(days: 1)),
        endTime.add(const Duration(days: 1)),
        const Color.fromARGB(255, 246, 10, 222),
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 3',
        startTime.add(const Duration(days: 10)),
        endTime.add(const Duration(days: 10)),
        const Color.fromARGB(255, 250, 246, 25),
        false,
      ),
    );
    return meetings;
  }
}
