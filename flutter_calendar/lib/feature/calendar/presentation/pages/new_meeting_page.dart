import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart';

//TODO: capire se usare lui, o il riverpod per addare.
void addMeeting(
    /* prende come input il DateTime creato dall'utente in add_meeting_button*/) {
  // Ottieni la data selezionata dallo stato del provider
  // final DateTime selectedDate =
  //     ref.read(meetingProvider.notifier).selectedDate;
  // final DateTime startTime =
  //     DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));

  // Meeting newMeeting = Meeting(
  //   'Nuovo Meeting ${meetingsOnSelectedDate.length ?? 0 + 1}',
  //   startTime,
  //   endTime,
  //   Colors.purpleAccent,
  //   false,
  // );
  // print("click =>");
  // print(newMeeting.toString());
  // ref.read(meetingProvider.notifier).addMeeting(newMeeting);
  print("ciaoo");
}

class NewMeetingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ottieni lo stato corrente del meeting e il notifier
    final meetingState = ref.watch(meetingProvider);
    final meetingNotifier = ref.read(meetingProvider.notifier);

    // Crea un TextEditingController con il nome dell'evento corrente
    TextEditingController textcontroller =
        TextEditingController(text: meetingNotifier.eventName);
    textcontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: meetingNotifier.eventName.length));

    // Costruisci la UI della pagina
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuovo Meeting'),
          leading: IconButton(
            // Naviga alla pagina principale quando l'icona viene premuta
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage())),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Stampa i dettagli del meeting e crea un nuovo meeting
                print(meetingNotifier.eventName);
                print(meetingNotifier.selectedDate);
                print(meetingNotifier.startTime);
                print(meetingNotifier.endTime);
                meetingNotifier.createMeeting();
              },
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: textcontroller,
                  // Aggiorna il nome dell'evento quando il testo cambia
                  onChanged: (value) => meetingNotifier.eventName = value,
                  decoration: const InputDecoration(
                    labelText: 'Nome evento',
                  ),
                ),
              ),
              ListTile(
                title: Text(
                    'Data: ${meetingNotifier.selectedDate.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  // Mostra un DatePicker quando il ListTile viene premuto
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: meetingNotifier.selectedDate,
                    firstDate: DateTime(2000, 1),
                    lastDate: DateTime(3000),
                  );
                  if (picked != null) {
                    // Aggiorna la data selezionata con la data scelta
                    meetingNotifier.updateSelectedDate(picked);
                  }
                },
              ),
              ListTile(
                title:
                    Text('Dalle: ${meetingNotifier.startTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  // Mostra un TimePicker quando il ListTile viene premuto
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: meetingNotifier.startTime,
                  );
                  if (picked != null) {
                    // Aggiorna l'ora di inizio con l'ora scelta
                    meetingNotifier.startTime = picked;
                  }
                },
              ),
              ListTile(
                  title:
                      Text('Alle: ${meetingNotifier.endTime.format(context)}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    // Mostra un TimePicker quando il ListTile viene premuto
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: meetingNotifier.endTime,
                    );
                    if (picked != null) {
                      // Aggiorna l'ora di fine con l'ora scelta
                      meetingNotifier.endTime = picked;
                    }
                  })
            ])));
  }
}
