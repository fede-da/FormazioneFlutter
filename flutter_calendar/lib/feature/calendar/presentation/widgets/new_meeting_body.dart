import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/widgets/time_selection_component.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMeetingBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final  tmpProvider = StateNotifierProvider<MeetingNotifier, CalendarMeetings>((ref) {
      return MeetingNotifier();
    });
    final MeetingNotifier meetingNotifierNewMeetingPage = ref.read(tmpProvider.notifier);

    meetingNotifierNewMeetingPage.selectedDate = ref.read(meetingProvider.notifier).selectedDate;

    TextEditingController textcontroller =
    TextEditingController(text: meetingNotifierNewMeetingPage.eventName);
    textcontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: meetingNotifierNewMeetingPage.eventName.length));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: textcontroller,
              onChanged: (value) => meetingNotifierNewMeetingPage.eventName = value,
              decoration: const InputDecoration(
                labelText: 'Nome evento',
              ),
            ),
          ),
          // DATE PICKER
          ListTile(
            title: Text(
                'Data: ${meetingNotifierNewMeetingPage.selectedDate.toLocal().toString().split(' ')[0]}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: meetingNotifierNewMeetingPage.selectedDate,
                firstDate: DateTime(2000, 1),
                lastDate: DateTime(3000),
              );
              if (picked != null) {
                meetingNotifierNewMeetingPage.updateSelectedDate(picked);
              }
            },
          ),

          // INITIAL TIME PICKER
          TimeSelectionTile(
            isStartTime: true,
            meetingNotifier: meetingNotifierNewMeetingPage,
          ),

          // END TIME PICKER
          TimeSelectionTile(
            isStartTime: false,
            meetingNotifier: meetingNotifierNewMeetingPage,
          ),
        ],
      ),
    );
  }
}
