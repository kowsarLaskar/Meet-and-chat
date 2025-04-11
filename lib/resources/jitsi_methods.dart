import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  List<String> participants = [];
  final _jitsiMeetPlugin = JitsiMeet();
  void createMeeting({
    required BuildContext context,
    required String room,
    String username = '',
    bool audioMuted = true,
    bool videoMuted = true,
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.currentUser!.displayName!;
      } else {
        name = username;
      }

      var options = JitsiMeetConferenceOptions(
        room: room,
        serverURL:
            "https://8x8.vc/vpaas-magic-cookie-9980c82e115f48ce96984fbd0a68221a/d5ed10-SAMPLE_APP",
        token:
            'eyJraWQiOiJ2cGFhcy1tYWdpYy1jb29raWUtOTk4MGM4MmUxMTVmNDhjZTk2OTg0ZmJkMGE2ODIyMWEvZDVlZDEwLVNBTVBMRV9BUFAiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE3NDMxNjk3OTMsImV4cCI6MTc0MzE3Njk5MywibmJmIjoxNzQzMTY5Nzg4LCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtOTk4MGM4MmUxMTVmNDhjZTk2OTg0ZmJkMGE2ODIyMWEiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOnRydWUsIm91dGJvdW5kLWNhbGwiOnRydWUsInNpcC1vdXRib3VuZC1jYWxsIjpmYWxzZSwidHJhbnNjcmlwdGlvbiI6dHJ1ZSwicmVjb3JkaW5nIjp0cnVlfSwidXNlciI6eyJoaWRkZW4tZnJvbS1yZWNvcmRlciI6ZmFsc2UsIm1vZGVyYXRvciI6dHJ1ZSwibmFtZSI6Imtvd3Nhcmxhc2thcjg5OSIsImlkIjoiZ29vZ2xlLW9hdXRoMnwxMDc1MjI5ODA4NTk4MjYzNzAxMTMiLCJhdmF0YXIiOiIiLCJlbWFpbCI6Imtvd3Nhcmxhc2thcjg5OUBnbWFpbC5jb20ifX0sInJvb20iOiIqIn0.dOPsCl8hZdhAqXKIoBWhAx5HkdsWMvphvPJfuEYU2e-KrS7r4lf3odMOZ2vlkIxsTSob3p-LkwHuGqc_taiSvX0wPbTTlV2PK-qLREc0JxF3UxZagWwjrxwGfeySAlFedo6Egc60K8vnGuOBorwu_vdffAFVpwi6Sjd246tO2Bh--FQ-_fgu19dP91VejLsut3qFRx-L__Oin265nIln38O0TQPd3zzSdQBxuZf6OVhSxTlzQrwbVh-1gL8Ci07lLEcjdDpanhUUxCWpa8IrMWVMgDoDumr0cKzvyULN4i4E6R69XD3d8z42XvGfxnYO-KZ1w4hQzubDh9u_8M6H7w',
        configOverrides: {
          "startWithAudioMuted": audioMuted,
          "startWithVideoMuted": videoMuted,
        },
        featureFlags: {
          FeatureFlags.lobbyModeEnabled: true,
          FeatureFlags.addPeopleEnabled: true,
          FeatureFlags.welcomePageEnabled: true,
          FeatureFlags.preJoinPageEnabled: true,
          FeatureFlags.unsafeRoomWarningEnabled: false,
          FeatureFlags.resolution: FeatureFlagVideoResolutions.resolution720p,
          FeatureFlags.audioFocusDisabled: true,
          FeatureFlags.audioMuteButtonEnabled: true,
          FeatureFlags.audioOnlyButtonEnabled: true,
          FeatureFlags.calenderEnabled: true,
          FeatureFlags.callIntegrationEnabled: true,
          FeatureFlags.carModeEnabled: true,
          FeatureFlags.closeCaptionsEnabled: true,
          FeatureFlags.conferenceTimerEnabled: true,
          FeatureFlags.chatEnabled: true,
          FeatureFlags.filmstripEnabled: true,
          FeatureFlags.fullScreenEnabled: true,
          FeatureFlags.helpButtonEnabled: true,
          FeatureFlags.inviteEnabled: true,
          FeatureFlags.androidScreenSharingEnabled: true,
          FeatureFlags.speakerStatsEnabled: true,
          FeatureFlags.kickOutEnabled: true,
          FeatureFlags.liveStreamingEnabled: true,
          FeatureFlags.meetingNameEnabled: true,
          FeatureFlags.meetingPasswordEnabled: true,
          FeatureFlags.notificationEnabled: true,
          FeatureFlags.overflowMenuEnabled: true,
          FeatureFlags.pipEnabled: true,
          FeatureFlags.pipWhileScreenSharingEnabled: true,
          FeatureFlags.preJoinPageHideDisplayName: true,
          FeatureFlags.raiseHandEnabled: true,
          FeatureFlags.reactionsEnabled: true,
          FeatureFlags.recordingEnabled: true,
          FeatureFlags.replaceParticipant: true,
          FeatureFlags.securityOptionEnabled: true,
          FeatureFlags.serverUrlChangeEnabled: true,
          FeatureFlags.settingsEnabled: true,
          FeatureFlags.tileViewEnabled: true,
          FeatureFlags.videoMuteEnabled: true,
          FeatureFlags.videoShareEnabled: true,
          FeatureFlags.toolboxEnabled: true,
          FeatureFlags.iosRecordingEnabled: true,
          FeatureFlags.iosScreenSharingEnabled: true,
          FeatureFlags.toolboxAlwaysVisible: true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.currentUser!.email,
          avatar: _authMethods.currentUser!.photoURL,
        ),
      );

      var listener = JitsiMeetEventListener(
        conferenceJoined: (url) {
          debugPrint("conferenceJoined: url: $url");
        },
        conferenceTerminated: (url, error) {
          debugPrint("conferenceTerminated: url: $url, error: $error");
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // Goes back to the previous screen
          } else {
            SystemNavigator
                .pop(); // Closes the app if no previous screen exists
          }
        },
        conferenceWillJoin: (url) {
          debugPrint("conferenceWillJoin: url: $url");
        },
        participantJoined: (email, name, role, participantId) {
          debugPrint(
            "participantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
          participants.add(participantId!);
        },
        participantLeft: (participantId) {
          debugPrint("participantLeft: participantId: $participantId");
        },
        audioMutedChanged: (muted) {
          debugPrint("audioMutedChanged: isMuted: $muted");
        },
        videoMutedChanged: (muted) {
          debugPrint("videoMutedChanged: isMuted: $muted");
        },
        endpointTextMessageReceived: (senderId, message) {
          debugPrint(
              "endpointTextMessageReceived: senderId: $senderId, message: $message");
        },
        screenShareToggled: (participantId, sharing) {
          debugPrint(
            "screenShareToggled: participantId: $participantId, "
            "isSharing: $sharing",
          );
        },
        chatMessageReceived: (senderId, message, isPrivate, timestamp) {
          debugPrint(
            "chatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate, timestamp: $timestamp",
          );
        },
        chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
        participantsInfoRetrieved: (participantsInfo) {
          debugPrint(
              "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
        },
        readyToClose: () {
          debugPrint("readyToClose");
        },
      );

      _firestoreMethods.addToMeetingsHistory(meetingId: room);
      await _jitsiMeetPlugin.join(options, listener);
    } catch (e, stackTrace) {
      debugPrint("Error in createMeeting: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }

  hangUp() async {
    await _jitsiMeetPlugin.hangUp();
  }

  setAudioMuted(bool? audioMuted) async {
    await _jitsiMeetPlugin.setAudioMuted(audioMuted!);
  }

  setVideoMuted(bool? videoMuted) async {
    await _jitsiMeetPlugin.setVideoMuted(videoMuted!);
  }

  sendEndpointTextMessage() async {
    var a = await _jitsiMeetPlugin.sendEndpointTextMessage(message: "HEY");
    debugPrint("$a");

    for (var p in participants) {
      var b =
          await _jitsiMeetPlugin.sendEndpointTextMessage(to: p, message: "HEY");
      debugPrint("$b");
    }
  }

  // toggleScreenShare(bool? enabled) async {
  //   await _jitsiMeetPlugin.toggleScreenShare(enabled!);

  //   setState(() {
  //     screenShareOn = enabled;
  //   });
  // }

  openChat() async {
    await _jitsiMeetPlugin.openChat();
  }

  sendChatMessage() async {
    var a = await _jitsiMeetPlugin.sendChatMessage(message: "HEY1");
    debugPrint("$a");

    for (var p in participants) {
      a = await _jitsiMeetPlugin.sendChatMessage(to: p, message: "HEY2");
      debugPrint("$a");
    }
  }

  closeChat() async {
    await _jitsiMeetPlugin.closeChat();
  }

  retrieveParticipantsInfo() async {
    var a = await _jitsiMeetPlugin.retrieveParticipantsInfo();
    debugPrint("$a");
  }
}
