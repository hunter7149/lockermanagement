import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification notification;

  const NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification.message),
      subtitle: Text(notification.timestamp.toString()),
    );
  }
}
