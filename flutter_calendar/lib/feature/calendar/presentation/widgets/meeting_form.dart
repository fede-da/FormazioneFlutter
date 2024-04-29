import 'package:flutter/material.dart';

///.
///
///
///
///
//TODO: DA RIVEDERE TUTTO!!!!
///
/// questa pagina non viene richiamata da nessuna parte
///
///
///
class MeetingBody extends StatefulWidget {
  final bool isStartTime;

   MeetingBody({super.key, required this.isStartTime});


  @override
  State<MeetingBody> createState() => _MeetingBodyState();
}

TextEditingController textcontroller = TextEditingController();
DateTime _selectedDate = DateTime.now();

class _MeetingBodyState extends State<MeetingBody> {
  late TimeOfDay initialTime;
  @override

  void initState() {
    super.initState();
    if (widget.isStartTime) {
      initialTime = const TimeOfDay(hour: 9, minute: 0);
    } else {
      initialTime = const TimeOfDay(hour: 18, minute: 0);
    }
  }
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // TEXTFLIED COMPONENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: textcontroller,
              decoration: const InputDecoration(
                labelText: 'Nome evento',
              ),
            ),
          ),
          // DATE PICKER COMPONENT
          ListTile(
            title: Text('Date: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000, 1),
                lastDate: DateTime(3000),
              );
            },
          ),
          ListTile(
            title: Text(
                '${widget.isStartTime ? 'Dalle' : 'Alle'}: ${initialTime.format(context)}'
            ),
            trailing: const Icon(Icons.access_time),
            onTap: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: initialTime,
              );
            },
          )
        ],
      ),
    );
  }
}
