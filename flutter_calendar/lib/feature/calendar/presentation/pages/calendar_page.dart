import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/add_meeting_button.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/meeting_container.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/sfcalendar_component.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ottieni gli incontri corrispondenti alla data selezionata
    final List<Meeting> meetingsOnSelectedDate =
        ref.read(meetingProvider.notifier).getMeetingsOnSelectedDate();

    int aboveSize = 3;
    int belowSize = 1;
    if (!(MediaQuery.of(context).size.height < 668.0)) {
      aboveSize = 5;
      belowSize = 4;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Calendario'),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: aboveSize,
                  child: SfCalendarComponent(
                    // Passa ref come parametro al widget SfCalendarComponent
                    ref: ref,
                    // Passa una funzione di callback per ricevere la lista degli appuntamenti del giorno selezionato
                    onAppointmentsSelected: (meetings) {
                      // Controlla se i meeting sono cambiati
                      // if (meetings != meetingsOnSelectedDate) {
                      // Utilizza Riverpod per aggiornare lo stato
                      ref
                          .read(meetingProvider.notifier)
                          .updateMeetings(meetings);
                      // }
                    },
                  ),
                ),
                Expanded(
                  flex: belowSize,
                  child: meetingsOnSelectedDate.isNotEmpty
                      ? ListView(
                          children:
                              MeetingContainer.asList(meetingsOnSelectedDate),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Nessun evento attualmente"),
                        ),
                ),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: AddMeetingButton(),
            ),
          ],
        ),
      ),
    );
  }
}
