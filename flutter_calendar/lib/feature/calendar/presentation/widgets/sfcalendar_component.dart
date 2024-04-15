import 'package:flutter/cupertino.dart';
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
  const SfCalendarComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meeting> selectedMeetings = [];
    CalendarMeetings calendarMeetings = ref.watch(meetingProvider);

    return SfCalendar(
      // Do not change Month otherwise ☠️
      view: CalendarView.month, //CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      //TODO: da usare riverpod.
      onTap: (test) {
        Meeting prova = test.appointments![0];
      },
      // onTap: (value) =>
      //     ref.read(meetingProvider.notifier).changeCurrentMeeting(value)
      // setState(() {
      //   // Aggiorna i meeting selezionati quando un giorno viene cliccato
      //   selectedMeetings = _getMeetingsOnDate(calendarTapDetails.date!);
      // });
    );
  }

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
