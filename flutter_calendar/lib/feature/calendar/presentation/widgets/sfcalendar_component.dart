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
    // Ottiene lo stato dei meeting dal provider.
    // final CalendarMeetings calendarMeetings = ref.watch(meetingProvider);

    return SfCalendar(
      // Imposta la vista del calendario su "mese".
      view: CalendarView.month,
      // Imposta la fonte dati per il calendario utilizzando il DataSource degli incontri.
      dataSource: MeetingDataSource(ref.watch(meetingProvider).meetings ?? []),
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
}
