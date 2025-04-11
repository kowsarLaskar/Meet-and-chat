import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class MeetingsHistory extends StatelessWidget {
  const MeetingsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final meeting = (snapshot.data! as dynamic).docs[index];
            return ListTile(
              title: Text('RoomName: ${meeting['meeting_id']}'),
              subtitle: Text(
                'Joined at: ${DateFormat.yMMMd().format((meeting['timestamp'] as Timestamp).toDate())}',
              ),
            );
          },
        );
      },
    );
  }
}
