import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/meeting_container.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/sfcalendar_component.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Meeting>? meetingsOnSelectedDate;

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
                // Passa una funzione di callback per ricevere la lista degli appuntamenti del giorno selezionato
                onAppointmentsSelected: (meetings) {
                  setState(() {
                    meetingsOnSelectedDate = meetings;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: meetingsOnSelectedDate != null &&
                      meetingsOnSelectedDate!.isNotEmpty
                  ? ListView(
                      children:
                          MeetingContainer.asList(meetingsOnSelectedDate!),
                    )
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
