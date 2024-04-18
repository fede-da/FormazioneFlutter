import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/meeting_container.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/sfcalendar_component.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Consumer: è utilizzato per accedere ai valori forniti da un provider
// senza dover ripetere manualmente la sua costruzione in ogni widget figlio.
// Accetta una funzione di creazione del widget come parametro builder,
// che viene chiamata ogni volta che il valore del provider cambia.
// Questo widget è particolarmente utile quando si lavora con provider come Riverpod p
// er gestire lo stato globale dell'applicazione.

/// `ConsumerWidget` è un widget che permette di ascoltare i cambiamenti di un provider
/// ricostruendo l'interfaccia utente in risposta a questi cambiamenti.
/// Estende `StatelessWidget` e aggiunge un parametro extra al metodo `build`: l'oggetto "ref".
/// Questo oggetto "ref" permette di interagire con i provider all'interno dell'albero dei widget.

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<Meeting>? meetingsOnSelectedDate =
    //     ref.watch(meetingProvider).meetings;
    final List<Meeting> meetingsOnSelectedDate =
        ref.watch(meetingsOnSelectedDateProvider);

    void addMeeting() {
      // Ottieni la data selezionata dallo stato del provider
      final DateTime selectedDate =
          ref.read(meetingProvider.notifier).selectedDate;
      final DateTime startTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
      final DateTime endTime = startTime.add(const Duration(hours: 2));

      Meeting newMeeting = Meeting(
        'Nuovo Meeting ${meetingsOnSelectedDate.length ?? 0 + 1}',
        startTime,
        endTime,
        Colors.purpleAccent,
        false,
      );
      print("click =>");
      print(newMeeting.toString());
      ref.read(meetingProvider.notifier).addMeeting(newMeeting);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Calendario'),
        ),
        // stack = sovrappone i propri figli, posizionandoli l'uno sull'altro.
        // I figli sono posizionati in base all'allineamento e alle loro proprietà top, right, bottom e left.
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SfCalendarComponent(
                    // Passa ref come parametro al widget SfCalendarComponent
                    ref: ref,
                    // Passa una funzione di callback per ricevere la lista degli appuntamenti del giorno selezionato
                    onAppointmentsSelected: (meetings) {
                      // Controlla se i meeting sono cambiati
                      if (meetings != meetingsOnSelectedDate) {
                        // Utilizza Riverpod per aggiornare lo stato
                        ref
                            .read(meetingProvider.notifier)
                            .updateMeetings(meetings);
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
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
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: addMeeting,
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
