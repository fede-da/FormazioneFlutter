import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart';

// Define a Provider to manage meeting data
final meetingProvider = StateProvider<Meeting>(
  (ref) => Meeting(
    eventName: '',
    selectedDate: DateTime.now(),
    startTime: TimeOfDay(hour: 9, minute: 0),
    endTime: TimeOfDay(hour: 18, minute: 0),
  ),
);

class Meeting {
  final String eventName;
  final DateTime selectedDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Meeting({
    required this.eventName,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
  });

  Meeting copyWith({
    String? eventName,
    DateTime? selectedDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return Meeting(
      eventName: eventName ?? this.eventName,
      selectedDate: selectedDate ?? this.selectedDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class NewMeetingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meeting = ref.watch(meetingProvider);
    final meetingState = ref.read(meetingProvider.notifier);
    TextEditingController _textcontroller = TextEditingController(text: meeting.eventName);
    _textcontroller.selection = TextSelection.fromPosition(TextPosition(offset: meeting.eventName.length));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuovo Meeting'),
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage())),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            //TODO: IMPLEMENTARE LOGICA PER AGGIUNGERE MEETING AL CALENDARIO
            IconButton(
              onPressed: () {
                // Add meeting logic (consider using a service or repository)
                print(meeting.eventName);
                print(meeting.selectedDate);
                print(meeting.startTime);
                print(meeting.endTime);
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
                  controller: _textcontroller,
                  onChanged: (value) => meetingState.update((state) => state.copyWith(eventName: value)),
                  decoration: const InputDecoration(
                    labelText: 'Nome evento',
                  ),
                ),
              ),
              ListTile(
                title: Text(
                    'Data: ${meeting.selectedDate.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: meeting.selectedDate,
                    firstDate: DateTime(2000, 1),
                    lastDate: DateTime(3000),
                  );
                  if (picked != null) {
                    meetingState.update(
                        (state) => state.copyWith(selectedDate: picked));
                  }
                },
              ),
              ListTile(
                title: Text('Dalle: ${meeting.startTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: meeting.startTime,
                  );
                  if (picked != null) {
                    meetingState
                        .update((state) => state.copyWith(startTime: picked));
                  }
                },
              ),
              ListTile(
                  title: Text('Alle: ${meeting.endTime.format(context)}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: meeting.endTime,
                    );
                    if (picked != null) {
                      meetingState
                          .update((state) => state.copyWith(endTime: picked));
                    }
                  })
            ])));
  }
}
