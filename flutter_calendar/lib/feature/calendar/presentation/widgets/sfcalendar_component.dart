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

  // Costruttore per SfCalendarComponent.
  const SfCalendarComponent({
    super.key,
    required this.onAppointmentsSelected,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lista degli incontri selezionati.
    final List<Meeting> selectedMeetings = [];
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
        onTap: (CalendarTapDetails details) {
          // Se ci sono incontri selezionati.
          if (details.appointments != null) {
            // Pulisce la lista degli incontri selezionati.
            selectedMeetings.clear();
            // Aggiunge gli incontri selezionati alla lista.
            selectedMeetings.addAll(details.appointments!.cast<Meeting>());
            // Passa gli incontri selezionati alla home
            onAppointmentsSelected(selectedMeetings);

            // Aggiorna la data selezionata nel provider
            ref
                .read(meetingProvider.notifier)
                .updateSelectedDate(details.date!);
          }
        }

        //TODO: capire come aggiungere un nuovo meeting in base al giorno selezioanto
        //onSelectionChanged: (CalendarSelectionDetails details) {
        //if (details.date != null) {
        // ref.read(meetingProvider.notifier).updateSelectedDate(details.date!);
        //}
        //  },
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
}
