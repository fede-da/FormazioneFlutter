import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/domain/models/meeting.dart';

class MeetingContainer extends StatelessWidget {
  const MeetingContainer({super.key, required this.eventName});

  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(eventName));
  }

  static List<MeetingContainer> asList(List<Meeting> meetings) {
    List<MeetingContainer> returns = [];
    List.generate(
      meetings.length,
      (index) =>
          returns.add(MeetingContainer(eventName: meetings[index].eventName)),
    );
    return returns;
  }
}
