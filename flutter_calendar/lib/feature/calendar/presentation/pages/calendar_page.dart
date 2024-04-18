import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/data/datasources/meeting_data_source.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
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
  Meeting? selectedMeeting;

  @override
  void initState() {
    super.initState();
    // Imposta i meeting selezionati per il giorno corrente all'avvio dell'app
    selectedMeetings = _getMeetingsOnDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var source = _getDataSource();
    int aboveSize = 3;
    int belowSize = 1;
    if (!(MediaQuery.of(context).size.height < 668.0)) {
      aboveSize = 5;
      belowSize = 4;
    }
    DateTime now = DateTime.now();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const HelloWorld(),
        ),
        body: Column(
          children: [
            Expanded(
              flex: aboveSize,
              child: SfCalendar(
                // Do not change Month otherwise ☠️
                view: CalendarView.month,
                dataSource: MeetingDataSource(source),
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:  MonthAppointmentDisplayMode.appointment
                    ),
                // minDate: DateTime(now.year, now.month, 1),
                // maxDate: DateTime(now.year, now.month + 1, 0),

                // by default the month appointment display mode set as Indicator, we can
                // change the display mode as appointment using the appointment display
                // mode property
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
              flex: belowSize,
              child: SingleChildScrollView(
                child: selectedMeeting == null
                    ? MeetingContainer(
                        meeting: new Meeting("eventName", DateTime.now(),
                            DateTime.now(), Colors.black, false),
                      )
                    : MeetingContainer(
                        meeting: selectedMeeting!,
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
