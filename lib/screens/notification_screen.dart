import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var notificationProvider = Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: FutureBuilder(
        future: notificationProvider.fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching notifications'));
          } else {
            return ListView.builder(
              itemCount: notificationProvider.notifications.length,
              itemBuilder: (context, index) {
                return NotificationTile(notification: notificationProvider.notifications[index]);
              },
            );
          }
        },
      ),
    );
  }
}
