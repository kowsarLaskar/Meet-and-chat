import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_options.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController _meetingIdController;
  late TextEditingController _nameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  final JitsiMethods _jitsiMeet = JitsiMethods();
  @override
  void initState() {
    super.initState();
    _meetingIdController = TextEditingController();
    _nameController = TextEditingController(
      text: _authMethods.currentUser!.displayName,
    );
  }

  _joinMeeting() {
    _jitsiMeet.createMeeting(
      room: _meetingIdController.text,
      username: _nameController.text,
      audioMuted: isAudioMuted,
      videoMuted: isVideoMuted,
      context: context,
    );
  }

  @override
  void dispose() {
    _meetingIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Join Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: _meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: secondaryBackgroundColor,
                border: InputBorder.none,
                filled: true,
                hintText: 'Enter Room-ID',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: _nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: secondaryBackgroundColor,
                border: InputBorder.none,
                filled: true,
                hintText: 'Name',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _joinMeeting(),
            splashColor: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Join',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOptions(
            text: 'Mute Audio',
            isMute: isAudioMuted,
            onChange: setAudioMute,
          ),
          MeetingOptions(
            text: 'Mute Video',
            isMute: isVideoMuted,
            onChange: setVideoMute,
          ),
        ],
      ),
    );
  }

  setAudioMute(bool? muted) async {
    setState(() {
      isAudioMuted = muted!;
    });
  }

  setVideoMute(bool? muted) async {
    setState(() {
      isVideoMuted = muted!;
    });
  }
}
