import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String message;
  final DateTime timestamp;

  AppNotification({
    required this.id,
    required this.message,
    required this.timestamp,
  });

  factory AppNotification.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AppNotification(
      id: doc.id,
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
