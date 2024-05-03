import 'package:flutter/material.dart';

import '../../../state/meeting_state.dart';

class DateSelectionComponent extends StatefulWidget {
  final MeetingNotifier meetingNotifier;

  const DateSelectionComponent({
    super.key,
    required this.meetingNotifier
  });

  @override
  State<DateSelectionComponent> createState() => _DateSelectionComponentState();
}

class _DateSelectionComponentState extends State<DateSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          'Data: ${widget.meetingNotifier.selectedDate.toLocal().toString().split(' ')[0]}'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.meetingNotifier.selectedDate,
          firstDate: DateTime(2000, 1),
          lastDate: DateTime(3000),
        );
        if (picked != null) {
          setState(() {
            widget.meetingNotifier.updateSelectedDate(picked);
          });

        }
      },
    );
  }
}
