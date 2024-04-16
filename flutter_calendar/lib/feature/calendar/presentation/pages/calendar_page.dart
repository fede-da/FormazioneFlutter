import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/meeting_container.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/sfcalendar_component.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              // Consumer: è utilizzato per accedere ai valori forniti da un provider
              // senza dover ripetere manualmente la sua costruzione in ogni widget figlio.
              // Accetta una funzione di creazione del widget come parametro builder,
              // che viene chiamata ogni volta che il valore del provider cambia.
              // Questo widget è particolarmente utile quando si lavora con provider come Riverpod p
              // er gestire lo stato globale dell'applicazione.
              child: Consumer(builder: (context, ref, _) {
                return SfCalendarComponent(
                  // Passa ref come parametro al widget SfCalendarComponent
                  ref: ref,
                  // Passa una funzione di callback per ricevere la lista degli appuntamenti del giorno selezionato
                  onAppointmentsSelected: (meetings) {
                    // Utilizza Riverpod per aggiornare lo stato
                    ref.read(meetingProvider.notifier).updateMeetings(meetings);
                  },
                );
              }),
            ),
            Expanded(
              flex: 1,
              child: Consumer(builder: (context, ref, _) {
                final List<Meeting>? meetingsOnSelectedDate =
                    ref.watch(meetingProvider).meetings;
                return meetingsOnSelectedDate != null &&
                        meetingsOnSelectedDate.isNotEmpty
                    ? ListView(
                        children:
                            MeetingContainer.asList(meetingsOnSelectedDate),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Nessun evento attualmente"),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
