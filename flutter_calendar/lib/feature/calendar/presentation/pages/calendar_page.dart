import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/add_meeting_button.dart';
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
    //TODO: controllare qui:

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
        // stack = sovrappone i propri figli, posizionandoli l'uno sull'altro.
        // I figli sono posizionati in base all'allineamento e alle loro proprietà top, right, bottom e left.
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
                      if (meetings != meetingsOnSelectedDate) {
                        // Utilizza Riverpod per aggiornare lo stato
                        ref
                            .read(meetingProvider.notifier)
                            .updateMeetings(meetings);
                        //TODO: grazie a lui si aggirona, ma è sbagliato perché ricostruisce tutto il provider
                        ref.invalidate(meetingsOnSelectedDateProvider);
                      }
                    },
                  ),
                ),
                //TODO: controllare qui:
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
