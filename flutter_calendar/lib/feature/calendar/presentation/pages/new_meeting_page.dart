import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/meeting_state.dart';
import '../widgets/check_icon_button.dart';
import '../widgets/date_selection_component.dart';
import '../widgets/text_event_component.dart';
import '../widgets/time_selection_component.dart';
import 'calendar_page.dart'; // Assumi che questo import sia corretto

class NewMeetingPage extends ConsumerWidget {
  const NewMeetingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tmpProvider =
        StateNotifierProvider<MeetingNotifier, CalendarMeetings>((ref) {
      return MeetingNotifier();
    });
    final MeetingNotifier meetingNotifierNewMeetingPage =
        ref.read(tmpProvider.notifier);

    meetingNotifierNewMeetingPage.selectedDate =
        ref.read(meetingProvider.notifier).selectedDate;

    TextEditingController textcontroller =
        TextEditingController(text: meetingNotifierNewMeetingPage.eventName);

    Meeting getMeeting() {
      return Meeting(
          meetingNotifierNewMeetingPage.eventName,
          DateTime(
            meetingNotifierNewMeetingPage.selectedDate.year,
            meetingNotifierNewMeetingPage.selectedDate.month,
            meetingNotifierNewMeetingPage.selectedDate.day,
            meetingNotifierNewMeetingPage.startTime.hour,
            meetingNotifierNewMeetingPage.startTime.minute,
          ),
          DateTime(
            meetingNotifierNewMeetingPage.selectedDate.year,
            meetingNotifierNewMeetingPage.selectedDate.month,
            meetingNotifierNewMeetingPage.selectedDate.day,
            meetingNotifierNewMeetingPage.endTime.hour,
            meetingNotifierNewMeetingPage.endTime.minute,
          ),
          Colors.deepPurpleAccent,
          false);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuovo Meeting'),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage())),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          CheckIconButton(onPressed: () => getMeeting()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // TEXT FIELD
            TextEventComponent(
              meetingNotifier: meetingNotifierNewMeetingPage,
              currentController: textcontroller,
            ),

            // DATE PICKER
            DateSelectionComponent(
                meetingNotifier: meetingNotifierNewMeetingPage),

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
      ),
    );
  }
}
