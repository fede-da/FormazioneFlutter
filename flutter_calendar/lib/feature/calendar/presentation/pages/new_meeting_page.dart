import 'package:flutter/material.dart';
import '../widgets/check_icon_button.dart';
import '../widgets/new_meeting_body.dart';
import 'calendar_page.dart'; // Assumi che questo import sia corretto



class NewMeetingPage extends StatelessWidget {
  const NewMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuovo Meeting'),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage())),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          CheckIconButton(),
        ],
      ),
      body: NewMeetingBody(),
    );
  }
}


