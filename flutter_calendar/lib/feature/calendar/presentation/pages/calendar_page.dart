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
                        //TODO: grazie a lui si aggirona, ma è sbagliato perché ricostruisce tutto il provider
                        ref.invalidate(meetingsOnSelectedDateProvider);
                      }
                    },
                  ),
                ),
                //TODO: controllare qui:
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
              right: 16,
              bottom: 16,
              child: AddMeetingButton(
                onAppointmentsSelected: addMeeting,
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
}
