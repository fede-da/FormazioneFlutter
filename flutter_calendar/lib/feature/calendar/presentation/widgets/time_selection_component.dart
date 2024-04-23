import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/state/meeting_state.dart';

class TimeSelectionTile extends StatefulWidget {
  final String title;
  final MeetingNotifier meetingNotifier;

  const TimeSelectionTile({
    required this.title,
    required this.meetingNotifier,
  });

  @override
  _TimeSelectionTileState createState() => _TimeSelectionTileState();
}

class _TimeSelectionTileState extends State<TimeSelectionTile> {
  late TimeOfDay initialTime;

  @override
  void initState() {
    super.initState();
    if (widget.title == 'Dalle') {
      initialTime = const TimeOfDay(hour: 9, minute: 0);
    } else {
      initialTime = const TimeOfDay(hour: 18, minute: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.title}: ${initialTime.format(context)}'),
      trailing: const Icon(Icons.access_time),
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (picked != null) {
          setState(() {
            initialTime = picked;
            if (widget.title == 'Dalle') {
              widget.meetingNotifier.startTime = picked;
            } else {
              widget.meetingNotifier.endTime = picked;
            }
          });
        }
      },
    );
  }
}
