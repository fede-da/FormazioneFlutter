import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/new_meeting_page.dart';

class AddMeetingButton extends StatelessWidget {
  // final VoidCallback onAppointmentsSelected;
  final TextEditingController descriptionController = TextEditingController();

  AddMeetingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NewMeetingPage()));
      },
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

class DateTimeForMeeting {
  final DateTime startTime;
  final DateTime endTime;

  DateTimeForMeeting({required this.startTime, required this.endTime});
}
