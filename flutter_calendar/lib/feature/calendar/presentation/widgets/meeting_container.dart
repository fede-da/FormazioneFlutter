import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Widget per rappresentare un singolo incontro.
class MeetingContainer extends ConsumerWidget {
  const MeetingContainer({super.key, required this.meeting});

  // Incontro da visualizzare nel container.
  final Meeting meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Costruzione del container contenente il nome dell'evento.
    // return SizedBox(
    //   width: double.infinity,
    //   height: 100,
    //   child: Text(meeting.eventName),
    // );
    return Card(
      color: meeting.background,
      elevation: 4, // Altezza dell'ombra della card
      shape: RoundedRectangleBorder(
        // Forma della card
        borderRadius: BorderRadius.circular(8), // Bordo arrotondato
      ),
      child: SizedBox(
        width: double.infinity, // Larghezza per riempire tutto lo schermo
        height: 60, // Altezza fissa a 60
        child: Center(
          child: Text(
            meeting.eventName,
            style: const TextStyle(
              fontSize: 16, // Dimensione del carattere
              fontWeight: FontWeight.bold, // Grassetto
            ),
          ),
        ),
      ),
    );
  }

  // Metodo statico per convertire una lista di incontri in una lista di MeetingContainer.
  static List<MeetingContainer> asList(List<Meeting> meetings) {
    return meetings
        .map((meeting) => MeetingContainer(meeting: meeting))
        .toList();
  }
}
