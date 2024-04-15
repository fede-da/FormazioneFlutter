import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

void calendarTapped(CalendarTapDetails details, BuildContext context) {
  if (details.targetElement == CalendarElement.appointment ||
      details.targetElement == CalendarElement.agenda) {
    final Appointment appointmentDetails = details.appointments![0];
  }
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(child: const Text('sdjhfgdjsuyhfghjgdsf')),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Text(
                      'sdjhfgdjsuyhfghjgdsf',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  child: const Row(
                    children: <Widget>[
                      Text('sdjhfgdjsuyhfghjgdsf',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'))
          ],
        );
      });
}
