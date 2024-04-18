import 'package:flutter/material.dart';

class AddMeetingButton extends StatelessWidget {
  final VoidCallback onAppointmentsSelected;

  const AddMeetingButton({super.key, required this.onAppointmentsSelected});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onAppointmentsSelected,
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.red,
        size: 30,
      ),
    );
  }
}
