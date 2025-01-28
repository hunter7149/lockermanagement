import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => _notifications;

  Future<void> fetchNotifications() async {
    try {
      _notifications = await NotificationService().getNotifications();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
