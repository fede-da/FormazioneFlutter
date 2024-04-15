import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void calendarTapped(CalendarTapDetails details, BuildContext context) {
  if (details.targetElement == CalendarElement.appointment ||
      details.targetElement == CalendarElement.agenda) {
    final DateTime selectedDate = details.date!;
    final List appointmentsOnSelectedDate = details.appointments!
        .where((appointment) =>
            appointment.startTime.day == selectedDate.day &&
            appointment.startTime.month == selectedDate.month &&
            appointment.startTime.year == selectedDate.year)
        .toList();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Appuntamenti del ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
            content: Container(
              height: 80,
              child: Column(
                children: appointmentsOnSelectedDate
                    .map((appointment) => Text(
                        '${appointment.subject} dalle ${appointment.startTime} alle ${appointment.endTime}'))
                    .toList(),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Chiudi'))
            ],
          );
        });
  }
}
