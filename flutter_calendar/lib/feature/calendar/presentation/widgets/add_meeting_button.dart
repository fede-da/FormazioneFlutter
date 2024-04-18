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

  void showPopupSelectDayAndTime() {
    final DateTime selectedDate = DateTime.now();
    final DateTime startTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    DateTime selectedDateTime = DateTime.now();

    // Conferma che aggiunge al provider
  }
}

class DateTimeForMeeting {
  final DateTime startTime;
  final DateTime endTime;

  DateTimeForMeeting({required this.startTime, required this.endTime});
}
