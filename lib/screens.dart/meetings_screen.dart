import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_methods.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({
    super.key,
  });
  final JitsiMethods _jitsiMethods = JitsiMethods();
  void createNewMeeting(BuildContext context) {
    var random = Random();
    var roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMethods.createMeeting(room: roomName, context: context);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/video-call',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () => createNewMeeting(context),
              title: 'New Meeting',
              icon: Icons.videocam,
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              title: 'Join Meeting',
              icon: Icons.add_box_rounded,
            ),
            HomeMeetingButton(
              onPressed: () {},
              title: 'Schedule',
              icon: Icons.calendar_today,
            ),
            HomeMeetingButton(
              onPressed: () {},
              title: 'Share Screen',
              icon: Icons.telegram,
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join meeting with just one click',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
