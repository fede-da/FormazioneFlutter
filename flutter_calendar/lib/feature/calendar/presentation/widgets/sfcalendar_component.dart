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
            selectedMeetings
                .addAll(details.appointments!.map((e) => e as Meeting));
            // Aggiorna lo stato dei meeting utilizzando Riverpod.
            ref.read(meetingProvider.notifier).updateMeetings(selectedMeetings);
            // Passa gli incontri selezionati alla home.
            onAppointmentsSelected(selectedMeetings);
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
    //TODO: cambiare dal moc al ref
    //  final List<Meeting> meetings = <Meeting>[];
    // Ottieni la lista dei meeting dallo stato del provider
    final List<Meeting>? meetings = ref.watch(meetingProvider).meetings;
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    // Se la lista dei meeting è null, restituisci una lista vuota
    if (meetings == null) {
      return <Meeting>[];
    }

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
        Colors.red,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.2',
        startTime,
        endTime,
        Colors.grey,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.3',
        startTime,
        endTime,
        Colors.blue,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.4',
        startTime,
        endTime,
        Colors.purpleAccent,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.5',
        startTime,
        endTime,
        Colors.yellowAccent,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.6',
        startTime,
        endTime,
        Colors.purpleAccent,
        false,
      ),
    );
    meetings.add(
      Meeting(
        'Conference 1.7',
        startTime,
        endTime,
        Colors.orange,
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
