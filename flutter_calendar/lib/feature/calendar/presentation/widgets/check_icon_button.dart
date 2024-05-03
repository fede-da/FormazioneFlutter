import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart'; // Assumi che questo import sia corretto
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/meeting.dart';

typedef MeetingCallBack = Meeting Function();

class CheckIconButton extends ConsumerWidget {
  final MeetingCallBack onPressed;
  const CheckIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingNotifier = ref.read(meetingProvider.notifier);

    return IconButton(
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
          meetingNotifier.addMeeting(onPressed());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      },
      icon: const Icon(Icons.check),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart'; // Assumi che questo import sia corretto
import 'package:flutter_calendar/feature/state/meeting_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckIconButton extends ConsumerWidget {
  final MeetingNotifier meetingNotifierNewMeetingPage;

  const CheckIconButton({
    super.key,
    required this.meetingNotifierNewMeetingPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingNotifier = ref.read(meetingProvider.notifier);

    return IconButton(
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
          meetingNotifier.addMeeting(meetingNotifierNewMeetingPage.getMeetingsOnDate(meetingNotifierNewMeetingPage.selectedDate)[0]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      },
      icon: const Icon(Icons.check),
    );
  }
}






 */

