import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/meeting_container.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/sfcalendar_component.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Meeting? selectedMeeting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Calendario'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SfCalendarComponent(
                // Passa una funzione di callback per ricevere l'appuntamento selezionato dalla SfCalendarComponent
                onAppointmentSelected: (meeting) {
                  setState(() {
                    selectedMeeting = meeting;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: selectedMeeting != null
                  ? MeetingContainer(meeting: selectedMeeting!)
                  : const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Nessun evento attualmente"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
