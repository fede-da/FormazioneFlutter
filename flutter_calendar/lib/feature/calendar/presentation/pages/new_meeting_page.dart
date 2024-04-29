import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/check_icon_button.dart';
import '../widgets/new_meeting_body.dart';
import 'calendar_page.dart'; // Assumi che questo import sia corretto

class NewMeetingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
