import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/data/datasources/meeting_data_source.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Il componente SfCalendarComponent è un widget Consumer che gestisce il calendario.
// Utilizza Riverpod per accedere allo stato dei meeting.
class SfCalendarComponent extends ConsumerWidget {
  final Function(List<Meeting>) onAppointmentsSelected;
  final WidgetRef ref;

  const SfCalendarComponent({
    super.key,
    required this.onAppointmentsSelected,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lista degli incontri selezionati.
    final List<Meeting> selectedMeetings =
        ref.watch(meetingsOnSelectedDateProvider);
    // Ottiene lo stato dei meeting dal provider.
    // final CalendarMeetings calendarMeetings = ref.watch(meetingProvider);

    return SfCalendar(
      // Imposta la vista del calendario su "mese".
      view: CalendarView.month,
      // Imposta la fonte dati per il calendario utilizzando il DataSource degli incontri.
      dataSource: MeetingDataSource(_getDataSource()),
      // Impostazioni per la visualizzazione del mese nel calendario.
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      // Gestisce l'evento onTap nel calendario.
      //TODO: controllare qui:
      onTap: (CalendarTapDetails details) {
        // Se ci sono incontri selezionati.
        // if (details.appointments != null) {
        // print("ontap => ");
        // print(selectedMeetings.toString());
        // Pulisce la lista degli incontri selezionati.
        // selectedMeetings.clear();
        // Aggiunge gli incontri selezionati alla lista.
        // selectedMeetings.addAll(details.appointments!.cast<Meeting>());
        // Passa gli incontri selezionati alla home
        // onAppointmentsSelected(selectedMeetings);

        // Aggiorna la data selezionata nel provider
        // ref.read(meetingProvider.notifier).updateSelectedDate(details.date!);
        // }
      },

      onSelectionChanged: (CalendarSelectionDetails details) {
        // if (details.date != null) {
        // Aggiorna la data selezionata nel provider
        ref.read(meetingProvider.notifier).updateSelectedDate(details.date!);
        // Ottieni gli incontri corrispondenti alla data selezionata
        List<Meeting> selectedMeetings =
            ref.read(meetingProvider.notifier).getMeetingsOnDate(details.date!);
        // Passa gli incontri selezionati alla home
        onAppointmentsSelected(selectedMeetings);
        // }
      },
    );
  }

  // Ottiene la lista dei dati degli incontri.
  List<Meeting> _getDataSource() {
    // Ottieni la lista dei meeting dallo stato del provider
    final List<Meeting>? meetings = ref.watch(meetingProvider).meetings;

    // Se la lista dei meeting è null, restituisci una lista vuota
    if (meetings == null) {
      return <Meeting>[];
    }

    return meetings;
  }

//   List<Meeting> _getDataSource() {
//     final List<Meeting> meetings = <Meeting>[];
//     final DateTime today = DateTime.now();
//     final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
//     final DateTime endTime = startTime.add(const Duration(hours: 2));
//
//     meetings.add(
//       Meeting(
//         'Conference 1',
//         startTime,
//         endTime,
//         const Color(0xFF0F8644),
//         false,
//       ),
//     );
//     meetings.add(
//       Meeting(
//         'Conference 2',
//         startTime.add(const Duration(days: 1)),
//         endTime.add(const Duration(days: 1)),
//         const Color.fromARGB(255, 246, 10, 222),
//         false,
//       ),
//     );
//     meetings.add(
//       Meeting(
//         'Conference 3',
//         startTime.add(const Duration(days: 10)),
//         endTime.add(const Duration(days: 10)),
//         const Color.fromARGB(255, 250, 246, 25),
//         false,
//       ),
//     );
//     return meetings;
//   }
// }
}
