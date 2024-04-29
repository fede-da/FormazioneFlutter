import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/time_selection_component.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMeetingBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingNotifier = ref.read(meetingProvider.notifier);
    TextEditingController textcontroller =
    TextEditingController(text: meetingNotifier.eventName);
    textcontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: meetingNotifier.eventName.length));

    return Padding(
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
    );
  }
}
