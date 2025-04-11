import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser?.uid)
      .collection('meetings')
      .orderBy('timestamp', descending: true)
      .snapshots();

  void addToMeetingsHistory({required String meetingId}) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('meetings')
            .add({
          'meeting_id': meetingId,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Error adding meeting to Firestore: $e");
    }
  }
}
