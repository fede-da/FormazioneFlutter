import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(ProviderScope(child: CalendarApp()));
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
  }
}

/// The hove page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var source = _getDataSource();
    //TODO: Source of selected
    var sourceContainer = MeetingContainer.asList(source);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
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
                  onTap: (calendarTapDetails) {
                    calendarTapped(calendarTapDetails, context);
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: GridView.count(
                    crossAxisCount: 1,
                    children: sourceContainer,
                  )),
            ],
          )),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'Conference',
        startTime.add(const Duration(days: 1)),
        endTime.add(const Duration(days: 1)),
        Color.fromARGB(255, 246, 10, 222),
        false));
    meetings.add(Meeting(
        'Conference',
        startTime.add(const Duration(days: 10)),
        endTime.add(const Duration(days: 10)),
        Color.fromARGB(255, 250, 246, 25),
        false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

void calendarTapped(CalendarTapDetails details, BuildContext context) {
  if (details.targetElement == CalendarElement.appointment ||
      details.targetElement == CalendarElement.agenda) {
    final Appointment appointmentDetails = details.appointments![0];
  }
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(child: new Text('sdjhfgdjsuyhfghjgdsf')),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'sdjhfgdjsuyhfghjgdsf',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  child: const Row(
                    children: <Widget>[
                      Text('sdjhfgdjsuyhfghjgdsf',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'))
          ],
        );
      });
}

class MeetingContainer extends StatelessWidget {
  const MeetingContainer({super.key, required this.eventName});

  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(eventName));
  }

  static List<MeetingContainer> asList(List<Meeting> meetings) {
    List<MeetingContainer> returns = [];
    List.generate(meetings.length, (index) {
      returns.add(MeetingContainer(eventName: meetings[index].eventName));
    });
    return returns;
  }
}
