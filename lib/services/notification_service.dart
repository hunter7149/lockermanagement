import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification.dart';

class NotificationService {
  final Query<Map<String, dynamic>> _notificationCollection = FirebaseFirestore.instance.collectionGroup('notifications');

  Future<List<AppNotification>> getNotifications() async {
    try {
      QuerySnapshot snapshot = await _notificationCollection.get();
      return snapshot.docs
          .map((doc) => AppNotification.fromFirestore(doc))
          .toList();
    } catch (error) {
      throw error;
    }
  }
}
