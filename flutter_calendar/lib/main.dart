import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart';
// import 'package:flutter_calendar/feature/state/tutorial_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: CalendarApp()));
}

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calendar Demo',
      home: MyHomePage(),
      // home: CounterContainer(),
    );
  }
}
