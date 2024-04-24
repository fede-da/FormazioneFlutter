import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/time_selection_component.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart';

class NewMeetingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ottieni lo stato corrente del meeting e il notifier
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
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage())),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (meetingNotifier.startTime.hour >
                      meetingNotifier.endTime.hour ||
                  (meetingNotifier.startTime.hour ==
                          meetingNotifier.endTime.hour &&
                      meetingNotifier.startTime.minute >
                          meetingNotifier.endTime.minute)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'L\'orario di inizio non può essere successivo all\'orario di fine!'),
                  ),
                );
              } else {
                meetingNotifier.createMeeting();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: textcontroller,
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
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: meetingNotifier.selectedDate,
                  firstDate: DateTime(2000, 1),
                  lastDate: DateTime(3000),
                );
                if (picked != null) {
                  meetingNotifier.updateSelectedDate(picked);
                }
              },
            ),
            TimeSelectionTile(
              isStartTime: true,
              meetingNotifier: meetingNotifier,
            ),
            TimeSelectionTile(
              isStartTime: false,
              meetingNotifier: meetingNotifier,
            ),
          ],
        ),
      ),
    );
  }
}
