import 'package:flutter/material.dart';

class AddMeetingButton extends StatelessWidget {
  // final VoidCallback onAppointmentsSelected;
  final TextEditingController descriptionController = TextEditingController();

  AddMeetingButton({super.key});

  void addMeeting(
      /* prende come input il DateTime creato dall'utente in add_meeting_button*/) {
    // Ottieni la data selezionata dallo stato del provider
    // final DateTime selectedDate =
    //     ref.read(meetingProvider.notifier).selectedDate;
    // final DateTime startTime =
    //     DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));

    // Meeting newMeeting = Meeting(
    //   'Nuovo Meeting ${meetingsOnSelectedDate.length ?? 0 + 1}',
    //   startTime,
    //   endTime,
    //   Colors.purpleAccent,
    //   false,
    // );
    // print("click =>");
    // print(newMeeting.toString());
    // ref.read(meetingProvider.notifier).addMeeting(newMeeting);
    print("ciaoo");
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //TODO: si rompe qui quando apro:
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            // return the widget you want to show in the dialog
            return AlertDialog(
              title: const Text('Dialog Title'),
              content: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    print(descriptionController.text);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.red,
        size: 30,
      ),
    );

    void showPopupSelectDayAndTime() {
      final DateTime selectedDate = DateTime.now();
      final DateTime startTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
      final DateTime endTime = startTime.add(const Duration(hours: 2));

      DateTime selectedDateTime = DateTime.now();

      // Conferma che aggiunge al provider
    }
  }
}

class DateTimeForMeeting {
  final DateTime startTime;
  final DateTime endTime;

  DateTimeForMeeting({required this.startTime, required this.endTime});
}
