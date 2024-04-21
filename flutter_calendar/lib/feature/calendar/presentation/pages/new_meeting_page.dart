import 'package:flutter/material.dart';
import 'package:flutter_calendar/feature/calendar/presentation/pages/calendar_page.dart';

class NewMeetingPage extends StatefulWidget {
  @override
  _NewMeetingPageState createState() => _NewMeetingPageState();
}

class _NewMeetingPageState extends State<NewMeetingPage> {
  final TextEditingController _eventNameController = TextEditingController();
  bool _allDayEvent = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //TODO: mettere l'add:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            icon: const Icon(Icons.check),
          )
        ],
        title: const Text('Nuovo Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _eventNameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                labelText: 'Nome evento',
              ),
            ),
            SwitchListTile(
              title: const Text('Tutto il giorno'),
              value: _allDayEvent,
              onChanged: (bool value) {
                setState(() {
                  _allDayEvent = value;
                });
              },
            ),
            ListTile(
              title: Text(
                  'Data: ${_selectedDate.toLocal().toString().split(' ')[0]}'), // Mostra solo la data
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000, 1),
                  lastDate: DateTime(3000),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Dalle: ${_startTime.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _startTime,
                );
                if (picked != null && picked != _startTime) {
                  setState(() {
                    _startTime = picked;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Alle: ${_endTime.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _endTime,
                );
                if (picked != null && picked != _endTime) {
                  setState(() {
                    _endTime = picked;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
