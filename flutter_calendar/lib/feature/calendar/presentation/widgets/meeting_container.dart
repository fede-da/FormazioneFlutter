import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeetingContainer extends ConsumerWidget {
  const MeetingContainer({Key? key, required this.meeting}) : super(key: key);

  final Meeting meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: Text(meeting.eventName));
  }

  static List<MeetingContainer> asList(List<Meeting> meetings) {
    return meetings
        .map((meeting) => MeetingContainer(meeting: meeting))
        .toList();
  }
}
