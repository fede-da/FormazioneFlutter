import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/data/datasources/meeting_data_source.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
// import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_tapped.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/meeting_container.dart';
import 'package:flutter_calendar/feature/state/tutorial_state.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Meeting> selectedMeetings = [];
  late Meeting selectedMeeting;

  @override
  void initState() {
    super.initState();
    // Imposta i meeting selezionati per il giorno corrente all'avvio dell'app
    selectedMeetings = _getMeetingsOnDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var source = _getDataSource();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const HelloWorld(),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SfCalendar(
                // Do not change Month otherwise ☠️
                view: CalendarView.month, //CalendarView.month,
                dataSource: MeetingDataSource(source),
                // by default the month appointment display mode set as Indicator, we can
                // change the display mode as appointment using the appointment display
                // mode property
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
                //TODO: da usare riverpod
                // onTap: () => {},
                // vado a pescare gli appointments del giorno selezioanto (appointment = Meeting)
                onTap: (calendarTapDetails) {
                  setState(() {
                    if ((calendarTapDetails.appointments == null) ||
                        calendarTapDetails.appointments!.isEmpty) {
                      return;
                    } else {
                      selectedMeeting = calendarTapDetails.appointments![0];
                    }
                  });
                },
              ),
            ),
            //TODO: da mettere il riverpod
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: MeetingContainer(
                  meeting: selectedMeeting,
                ),
              ),
            ),
          ],
        ),
      ),
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

  List<Meeting> _getMeetingsOnDate(DateTime date) {
    return _getDataSource().where((meeting) {
      return meeting.from.day == date.day &&
          meeting.from.month == date.month &&
          meeting.from.year == date.year;
    }).toList();
  }
}
