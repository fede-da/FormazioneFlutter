import 'package:flutter/material.dart';

import '../../../state/meeting_state.dart';

class TextEventComponent extends StatefulWidget {
  final MeetingNotifier meetingNotifier;
  final TextEditingController currentController;

  const TextEventComponent({
    super.key,
    required this.meetingNotifier,
    required this.currentController,
  });

  @override
  State<TextEventComponent> createState() => _TextEventComponentState();
}

class _TextEventComponentState extends State<TextEventComponent> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: widget.currentController,
        onChanged: (value) => widget.meetingNotifier.eventName = value,
        decoration: const InputDecoration(
          labelText: 'Nome evento',
        ),
      ),
    );
  }
}
